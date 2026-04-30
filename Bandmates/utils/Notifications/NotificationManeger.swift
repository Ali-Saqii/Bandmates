//
//  NotificationManeger.swift
//  Bandmates
//
//  Created by Mac mini on 28/04/2026.
//

//
//  NotificationManager.swift
//  Bandmates
//
//  Created by Mac mini on 30/03/2026.
//
import Foundation
import SwiftUI
import UserNotifications
import Combine

extension Notification.Name {
    static let newNotificationReceived = Notification.Name("newNotificationReceived")
}

class NotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {

    static let shared = NotificationManager()
    @Published var deviceToken: String?
    @Published var permissionGranted = false

    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    
    func registerDeviceToken(_ tokenData: Data) {
        let token = tokenData.map { String(format: "%02.2hhx", $0) }.joined()
        self.deviceToken = token
        
        Task {
            await sendTokenToBackend(token)
        }
    }
    
    private func sendTokenToBackend(_ token: String) async {
        guard let url = URL(string: "http://localhost:3000/user/device-token") else { return }
        guard let authToken = UserDefaults.standard.string(forKey: "authToken") else { return }
        
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        req.httpBody = try? JSONSerialization.data(withJSONObject: ["device_token": token])
        
        do {
            let (_, _) = try await URLSession.shared.data(for: req)
            print("✅ Device token registered")
        } catch {
            print("❌ Failed to register token: \(error)")
        }
    }
    func requestPermission() async {
        do {
            let granted = try await UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .badge, .sound])
            await MainActor.run { permissionGranted = granted }
        } catch {
            print("❌ Notification permission error: \(error)")
        }
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .badge, .sound])
        NotificationCenter.default.post(name: .newNotificationReceived, object: nil)
    }

    func updateBadge(count: Int) {
        UNUserNotificationCenter.current().setBadgeCount(count) { error in
            if let error { print("Badge update error: \(error)") }
        }
    }

    func clearBadge() {
        updateBadge(count: 0)
    }
}
