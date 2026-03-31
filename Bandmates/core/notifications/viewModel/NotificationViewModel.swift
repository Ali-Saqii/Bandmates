//
//  NotificationViewModel.swift
//  Bandmates
//
//  Created by Mac mini on 30/03/2026.
//

import Foundation
import Combine

class NotificationViewModel: ObservableObject {
    @Published var Notifications: [NotificationModel]? = [
        NotificationModel(
            title: "Bandmate Request",
            body: "Alex Rivera wants to join your band 'The Echoes'.",
            Date: Date().adding(hours: -1),
            isRead: false
        ),
        NotificationModel(
            title: "New Comment on Album",
            body: "Jordan left a comment on your album 'Midnight Sessions'.",
            Date: Date().adding(hours: -3),
            isRead: false
        ),
        NotificationModel(
            title: "Subscription Renewed",
            body: "Your Pro Plan subscription has been successfully renewed for $9.99/month.",
            Date: Date().adding(hours: -5),
            isRead: true
        ),
        NotificationModel(
            title: "Bandmate Request Accepted",
            body: "Sam Loch accepted your request to join 'Neon Wolves'.",
            Date: Date().adding(days: -1),
            isRead: false
        ),
        NotificationModel(
            title: "Payment Failed",
            body: "We couldn't process your subscription payment. Please update your billing info.",
            Date: Date().adding(days: -1),
            isRead: true
        ),
        NotificationModel(
            title: "Album Liked",
            body: "Your album 'Fade to Blue' received 128 new likes today.",
            Date: Date().adding(days: -2),
            isRead: false
        ),
        NotificationModel(
            title: "New Bandmate Suggestion",
            body: "Based on your genre, Maya Tones could be a great fit for your band.",
            Date: Date().adding(days: -3),
            isRead: true
        ),
        NotificationModel(
            title: "Comment Reply",
            body: "Chris replied to your comment on 'Summer Riff Vol. 2'.",
            Date: Date().adding(days: -4),
            isRead: true
        ),
        NotificationModel(
            title: "Subscription Expiring Soon",
            body: "Your Pro Plan expires in 3 days. Renew now to keep your features.",
            Date: Date().adding(days: -5),
            isRead: false
        ),
        NotificationModel(
            title: "Collaboration Invite",
            body: "Luna Beats invited you to collaborate on the track 'Golden Hour'.",
            Date: Date().adding(days: -6),
            isRead: false
        )
    ]
    @Published var readedNotifications: [NotificationModel]? = nil
    @Published var UnReadNotifications: [NotificationModel]? = nil
    init() {
        getReadedNotifications()
        getUnReadedNotifications()
    }
    private func getReadedNotifications() {
        guard let notifications = Notifications else {return}
        self.readedNotifications = notifications.filter({$0.isRead == true})
    }
    
    private func getUnReadedNotifications() {
        guard let notifications = Notifications else {return}
        self.UnReadNotifications = notifications.filter({$0.isRead == false})
    }
}


private extension Date {
    func adding(days: Int = 0, hours: Int = 0) -> Date {
        Calendar.current.date(byAdding: DateComponents(day: days, hour: hours), to: self) ?? self
    }
}



