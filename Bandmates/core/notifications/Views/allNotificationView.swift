//
//  allNotificationView.swift
//  Bandmates
//
//  Created by Mac mini on 30/03/2026.
//

import SwiftUI

struct allNotificationView: View {
    @EnvironmentObject var nvm : NotificationViewModel
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            if nvm.Notifications != nil {
                ScrollView {
                    if let allNotifications = nvm.Notifications {
                        VStack(spacing: 10) {
                            ForEach(allNotifications) { notification in
                                notificationRowView(Notification: notification)
                                    .padding(.horizontal)
                                Divider()
                            }
                        }
                    } else {
                        
                    }
                }.scrollIndicators(.hidden)
                    .scrollBounceBehavior(.basedOnSize)
            } else {
                NoBandmatesView(icon: "bell.fill", height: 70, width: 70, title: "No Notifications!", subTitle: "You have no new notifications at the moment. Check back later for updates!", titleFont: .dmSans(20, weight: .semiBold), subTitleFont: .dmSans(14, weight: .medium), color: Color.background.opacity(0.3))
                    .overlay(alignment: .topTrailing) {
                        Circle()
                            .fill(Color.background)
                            .frame(width: 20, height: 20)
                            .overlay {
                                Text("\(0)")
                                    .foregroundStyle(.white)
                                    .font(.caption.bold())
                            }
                            .offset(x: -90, y: 45)
                    }
            }
        }
    }
}

#Preview {
    allNotificationView()
        .environmentObject(NotificationViewModel())
}
