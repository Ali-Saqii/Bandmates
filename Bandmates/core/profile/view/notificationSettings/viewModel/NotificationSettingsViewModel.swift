//
//  NotificationSettingsViewModel.swift
//  Bandmates
//
//  Created by Mac mini on 04/05/2026.
//

import Foundation
import Combine

class NotificationSettingsViewModel: ObservableObject {
    @Published var settings = NotificationSettings(
        systemAnnouncements:  true,
        bandmateActivity:     true,
        commentsNotification: false,
        collectionUpdates:    false
    )
    @Published var isLoading = false

    private var token: String {
        UserDefaults.standard.string(forKey: "auth_token") ?? ""
    }
    private var cancellables = Set<AnyCancellable>()

    init() { fetchSettings() }

    func fetchSettings() {
        guard let url = URL(string: "http://localhost:3000/user/getnotification-settings") else { return }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: NotificationSettingsResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("❌ Fetch settings error:", error)
                }
            } receiveValue: { [weak self] response in
                if response.success {
                    self?.settings = response.data
                }
            }
            .store(in: &cancellables)
    }

    func updateSetting(key: String, value: Bool) {
        guard let url = URL(string: "http://localhost:3000/user/put/notification-settings") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: [key: value])

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("❌ Update setting error:", error)
                }
            } receiveValue: { data in
                print("✅ Setting updated:", String(data: data, encoding: .utf8) ?? "")
            }
            .store(in: &cancellables)
    }
}
