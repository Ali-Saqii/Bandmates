//
//  notificationRowView.swift
//  Bandmates
//
//  Created by Mac mini on 30/03/2026.
//

import SwiftUI

struct notificationRowView: View {
    let Notification : AppNotification
    var body: some View {
        HStack(alignment:.top) {
            VStack(alignment:.leading,spacing: 10) {
                Text(Notification.title)
                    .foregroundStyle(Notification.is_read ?.gray : .black)
                    .font(.dmSans(15, weight: .semiBold))
                Text(Notification.body)
                    .foregroundStyle(Notification.is_read ?.gray : .black)
                    .font(.dmSans(13, weight: .regular))
                    .lineLimit(3)
                Text("\(Notification.createdAt)")
                    .foregroundStyle(.gray)
                    .font(.dmSans(14, weight: .medium))
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            Image(systemName:Notification.is_read ? "envelope.open" : "envelope")
                .foregroundStyle(Notification.is_read ? Color.gray : Color.background)
                .padding(.horizontal)
        }.overlay(alignment: .topLeading) {
            Circle()
                .fill(Color.blue.opacity(Notification.is_read == true ? 0: 1))
                .frame(width: 8, height: 8)
        }
    }
}

#Preview {
    notificationRowView(Notification:  AppNotification(id: "", user_id: "", type: "", title: "", body: "", is_read: false, sender_id: "", createdAt: ""))
}
