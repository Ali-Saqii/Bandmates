//
//  notificatinService.swift
//  Bandmates
//
//  Created by Mac mini on 30/03/2026.
//

import Foundation

class NotificationService {
    static let shared = NotificationService()

    private let base = "http://localhost:3000/user"

    private var token: String {
        UserDefaults.standard.string(forKey: "auth_token") ?? ""
    }

    private func request(_ path: String, method: String = "GET", body: [String: Any]? = nil) -> URLRequest {
        var req = URLRequest(url: URL(string: "\(base)\(path)")!)
        req.httpMethod = method
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        if let body {
            req.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        return req
    }

    // GET /notifications
    func getNotifications(page: Int = 1, type: String? = nil) async throws -> NotificationsResponse {
        var path = "/notifications?page=\(page)&limit=20"
        if let type { path += "&type=\(type)" }
        let (data, _) = try await URLSession.shared.data(for: request(path))
        return try JSONDecoder().decode(NotificationsResponse.self, from: data)
    }

    // GET /notifications/unread-count
    func getUnreadCount() async throws -> Int {
        let (data, _) = try await URLSession.shared.data(for: request("/notifications/unread-count"))
        let res = try JSONDecoder().decode(UnreadCountResponse.self, from: data)
        return res.unread_count
    }

    // PATCH /notifications/:id/read
    func markAsRead(id: String) async throws {
        let (_, _) = try await URLSession.shared.data(for: request("/notifications/\(id)/read", method: "PATCH"))
    }

    // PATCH /notifications/read-all
    func markAllAsRead() async throws {
        let (_, _) = try await URLSession.shared.data(for: request("/notifications/read-all", method: "PATCH"))
    }

    // DELETE /notifications/:id
    func deleteNotification(id: String) async throws {
        let (_, _) = try await URLSession.shared.data(for: request("/notifications/\(id)", method: "DELETE"))
    }

    // DELETE /notifications/clear-all
    func clearAll() async throws {
        let (_, _) = try await URLSession.shared.data(for: request("/notifications/clear-all", method: "DELETE"))
    }
}
