//
//  UnReadNotificationView.swift
//  Bandmates
//
//  Created by Mac mini on 30/03/2026.
//

import SwiftUI

struct UnReadNotificationView: View {
    @EnvironmentObject var nvm : NotificationViewModel
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            if nvm.UnReadNotifications != nil {
                ScrollView {
                    if let allNotifications = nvm.UnReadNotifications {
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
                NoBandmatesView(icon: "checkmark.circle.fill", height: 70, width: 70, title: "No Unreads!", subTitle: "You have no unreaded notifications notifications at the moment. Check back later for updates!", titleFont: .dmSans(20, weight: .semiBold), subTitleFont: .dmSans(14, weight: .medium), color: Color.background.opacity(0.3))
            }
        }
    }
}

#Preview {
    UnReadNotificationView()
        .environmentObject(NotificationViewModel())
}
