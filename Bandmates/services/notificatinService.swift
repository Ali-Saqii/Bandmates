//
//  NotificationService.swift
//  Bandmates
//

import Foundation

// Custom error for auth failures
enum NotificationServiceError: Error {
    case notAuthenticated
}

class NotificationService {
    static let shared = NotificationService()

    // ✅ FIX #1 — Replace localhost with your Mac's LAN IP
    // Find it: System Settings → Wi-Fi → Details
    private let base = "http://localhost:3000/user"  // ← change X to your actual IP

    private var token: String {
        UserDefaults.standard.string(forKey: "auth_token") ?? ""
    }

    // ✅ FIX #2 — Function is now `throws` so auth failures surface properly
    private func request(
        _ path: String,
        method: String = "GET",
        body: [String: Any]? = nil
    ) throws -> URLRequest {

        guard !token.isEmpty else {
            throw NotificationServiceError.notAuthenticated  // throws instead of silent dummy request
        }
        print("🔑 TOKEN:", token.isEmpty ? "EMPTY — yahi problem hai!" : token.prefix(20))

        guard let url = URL(string: "\(base)\(path)") else {
            throw URLError(.badURL)
        }

        var req = URLRequest(url: url)
        req.httpMethod = method
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        if let body {
            // ✅ FIX #4 — Removed markdown [name](url) wrapping from JSONSerialization
            req.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }

        return req
    }

    // ✅ FIX #3 — All URLSession.shared.data calls cleaned (no more [name](url) syntax)
    //             request() now needs `try` since it throws

    func getNotifications(page: Int = 1, type: String? = nil) async throws -> NotificationsResponse {
        var path = "/notifications?page=\(page)&limit=20"
        if let type { path += "&type=\(type)" }
        let (data, _) = try await URLSession.shared.data(for: try request(path))
        return try JSONDecoder().decode(NotificationsResponse.self, from: data)
    }

    func getUnreadCount() async throws -> Int {
        let (data, _) = try await URLSession.shared.data(for: try request("/notifications/unread-count"))
        let res = try JSONDecoder().decode(UnreadCountResponse.self, from: data)
        return res.unread_count
    }

    func markAsRead(id: String) async throws {
        _ = try await URLSession.shared.data(for: try request("/notifications/\(id)/read", method: "PATCH"))
    }

    func markAllAsRead() async throws {
        _ = try await URLSession.shared.data(for: try request("/notifications/read-all", method: "PATCH"))
    }

    func deleteNotification(id: String) async throws {
        _ = try await URLSession.shared.data(for: try request("/notifications/\(id)", method: "DELETE"))
    }

    func clearAll() async throws {
        _ = try await URLSession.shared.data(for: try request("/notifications/clear-all", method: "DELETE"))
    }
}
