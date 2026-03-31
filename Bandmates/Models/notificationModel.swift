//
//  notificationModel.swift
//  Bandmates
//
//  Created by Mac mini on 30/03/2026.
//

import Foundation

import Combine

struct NotificationModel: Codable, Identifiable, Hashable {
    var id = UUID().uuidString
    let title: String
    let body: String
    let Date : Date
    let isRead : Bool
}
