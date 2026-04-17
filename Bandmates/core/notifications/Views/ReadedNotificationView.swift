//
//  ReadedNotificationView.swift
//  Bandmates
//
//  Created by Mac mini on 30/03/2026.
//

import SwiftUI

struct ReadedNotificationView: View {
    @EnvironmentObject var nvm : NotificationViewModel
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            if nvm.readedNotifications != nil {
                ScrollView {
                    if let allNotifications = nvm.readedNotifications {
                        VStack(spacing: 10) {
                            ForEach(allNotifications) { notification in
                                notificationRowView(Notification: notification)
                                    .padding(.horizontal)
                                Divider()
                            }
                        }
                    }
                }.scrollIndicators(.hidden)
                    .scrollBounceBehavior(.basedOnSize)
            } else {
                NoBandmatesView(icon: "exclamationmark.circle.fill", height: 70, width: 70, title: "No Reades!", subTitle: "You have no readed notifications at the moment. Check notofication inbox", titleFont: .dmSans(20, weight: .semiBold), subTitleFont: .dmSans(14, weight: .medium), color: Color.background.opacity(0.3))
            }
        }
    }
}

#Preview {
    ReadedNotificationView()
        .environmentObject(NotificationViewModel())
}
