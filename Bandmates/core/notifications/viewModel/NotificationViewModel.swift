//
//  NotificationViewModel.swift
//  Bandmates
//
//  Created by Mac mini on 30/03/2026.
//

import Foundation
import Combine
import UserNotifications

@MainActor
class NotificationViewModel: ObservableObject {
    @Published var notifications: [AppNotification] = []
    @Published var unreadCount: Int = 0
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    var readNotifications: [AppNotification] {
        notifications.filter { $0.is_read }
    }

    var unreadNotifications: [AppNotification] {
        notifications.filter { !$0.is_read }
    }
    private let service             = NotificationService.shared
    private let notificationManager = NotificationManager.shared
    private var cancellables        = Set<AnyCancellable>()
    private var pollingTask: Task<Void, Never>?

    init() {
        setupPushListener()
        startPolling()
        Task { await fetchFromBackend() }
    }

    deinit {
        pollingTask?.cancel()
    }
    private func setupPushListener() {
        NotificationCenter.default.publisher(for: .newNotificationReceived)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                Task { await self?.fetchFromBackend() }
            }
            .store(in: &cancellables)
    }
    private func startPolling() {
        pollingTask = Task {
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(5))
                await checkForNewNotifications()
            }
        }
    }
    private func checkForNewNotifications() async {
        do {
            let count = try await service.getUnreadCount()
            if count > unreadCount {
                await fetchFromBackend()
            }
        } catch {
            print("Polling check failed: \(error)")
        }
    }
    func fetchFromBackend() async {
        isLoading = true
        defer { isLoading = false }
        do {
            async let notifFetch = service.getNotifications()
            async let countFetch = service.getUnreadCount()
            let (response, count) = try await (notifFetch, countFetch)

            let fetched = response.data

            let existingIds = Set(notifications.map { $0.id })
            let newOnes = fetched.filter { !existingIds.contains($0.id) }

            for notif in newOnes {
                await showLocalBanner(notif)
            }
            notifications = fetched
            unreadCount   = count
            notificationManager.updateBadge(count: count)
        } catch {
            errorMessage = "Failed to load: \(error.localizedDescription)"
        }
    }
    private func showLocalBanner(_ notif: AppNotification) async {
        let content          = UNMutableNotificationContent()
        content.title        = notif.title
        content.body         = notif.body
        content.sound        = .default
        content.badge        = (unreadCount + 1) as NSNumber
        content.userInfo     = ["type": notif.type, "id": notif.id]

        let request = UNNotificationRequest(
            identifier: notif.id,
            content: content,
            trigger: nil
        )
        try? await UNUserNotificationCenter.current().add(request)
    }
    func markAsRead(_ notification: AppNotification) async {
        guard !notification.is_read else { return }
        do {
            try await service.markAsRead(id: notification.id)

            if let i = notifications.firstIndex(where: { $0.id == notification.id }) {
                notifications[i] = notification.asRead()
            }
            unreadCount = max(0, unreadCount - 1)
            notificationManager.updateBadge(count: unreadCount)

        } catch {
            errorMessage = error.localizedDescription
        }
    }
    func markAllAsRead() async {
        do {
            try await service.markAllAsRead()
            notifications = notifications.map { $0.asRead() }
            unreadCount   = 0
            notificationManager.clearBadge()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    func delete(_ notification: AppNotification) async {
        do {
            try await service.deleteNotification(id: notification.id)
            notifications.removeAll { $0.id == notification.id }
            if !notification.is_read {
                unreadCount = max(0, unreadCount - 1)
                notificationManager.updateBadge(count: unreadCount)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    func clearAll() async {
        do {
            try await service.clearAll()
            notifications = []
            unreadCount   = 0
            notificationManager.clearBadge()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    func onScreenAppear() async {
        await fetchFromBackend()
        notificationManager.clearBadge()
    }
}
