//
//  notificationRowView.swift
//  Bandmates
//
//  Created by Mac mini on 30/03/2026.
//

import SwiftUI

struct notificationRowView: View {
    let Notification : NotificationModel
    var body: some View {
        HStack(alignment:.top) {
            VStack(alignment:.leading,spacing: 10) {
                Text(Notification.title)
                    .foregroundStyle(Notification.isRead ?.gray : .black)
                    .font(.dmSans(15, weight: .semiBold))
                Text(Notification.body)
                    .foregroundStyle(Notification.isRead ?.gray : .black)
                    .font(.dmSans(13, weight: .regular))
                    .lineLimit(3)
                Text("\(Notification.Date.billingFormatted)")
                    .foregroundStyle(.gray)
                    .font(.dmSans(14, weight: .medium))
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            Image(systemName:Notification.isRead ? "envelope.open" : "envelope")
                .foregroundStyle(Notification.isRead ? Color.gray : Color.background)
                .padding(.horizontal)
        }.overlay(alignment: .topLeading) {
            Circle()
                .fill(Color.blue.opacity(Notification.isRead == true ? 0: 1))
                .frame(width: 8, height: 8)
        }
    }
}

#Preview {
    notificationRowView(Notification:  NotificationModel(
        title: "Collaboration Invite",
        body: "Luna Beats invited you to collaborate on the track 'Golden Hour'.",
        Date: Date(),
        isRead: false
    ))
}
