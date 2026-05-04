//
//  notificationModel.swift
//  Bandmates
//
//  Created by Mac mini on 30/03/2026.
//

import Foundation

struct AppNotification: Identifiable, Codable,Hashable {
    let id: String
    let user_id: String
    let type: String
    let title: String
    let body: String
    let is_read: Bool
    let sender_id: String?
    let createdAt: String
}

struct NotificationsResponse: Codable,Hashable {
    let success: Bool
    let total: Int
    let page: Int
    let data: [AppNotification]
}

struct UnreadCountResponse: Codable,Hashable {
    let success: Bool
    let unread_count: Int
}

// ── ✅ ADDED: lets ViewModel flip is_read locally without a full re-fetch ──
extension AppNotification {
    func asRead() -> AppNotification {
        AppNotification(
            id:        id,
            user_id:   user_id,
            type:      type,
            title:     title,
            body:      body,
            is_read:   true,          // ← only this changes
            sender_id: sender_id,
            createdAt: createdAt
        )
    }
}
