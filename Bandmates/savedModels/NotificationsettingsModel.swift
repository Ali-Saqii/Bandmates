//
//  NotificationsettingsModel.swift
//  Bandmates
//
//  Created by Mac mini on 04/05/2026.
//

import Foundation
struct NotificationSettings: Codable {
    var systemAnnouncements:  Bool
    var bandmateActivity:     Bool
    var commentsNotification: Bool
    var collectionUpdates:    Bool
}

struct NotificationSettingsResponse: Codable {
    let success: Bool
    let data: NotificationSettings
}
