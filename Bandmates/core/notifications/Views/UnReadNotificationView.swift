//
//  UnReadNotificationView.swift
//  Bandmates
//
//  Created by Mac mini on 30/03/2026.
//

import SwiftUI

struct UnReadNotificationView: View {
    @EnvironmentObject var nvm : NotificationViewModel
    @State private var selectedNotification:AppNotification? = nil
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
           
             
                    if !nvm.unreadNotifications.isEmpty {
                        ScrollView {
                        VStack(spacing: 10) {
                            ForEach(nvm.unreadNotifications) { notification in
                               
                                    notificationRowView(Notification: notification)
                                    .padding(.horizontal)
                                    .onTapGesture {
                                        selectedNotification = notification
                                        Task {
                                            await nvm.markAsRead(notification)
                                        }
                                    }
                                    
                                Divider()
                            }
                        }
                    }.scrollIndicators(.hidden)
                            .scrollBounceBehavior(.basedOnSize)
                } else {
                    NoBandmatesView(icon: "checkmark.circle.fill", height: 70, width: 70, title: "No Unreads!", subTitle: "You have no unreaded notifications notifications at the moment. Check back later for updates!", titleFont: .dmSans(20, weight: .semiBold), subTitleFont: .dmSans(14, weight: .medium), color: Color.background.opacity(0.3))
                }
            
        }.navigationDestination(item: $selectedNotification) { notification in
            if notification.type == "" {
                Bandmates()
            }else if notification.type == "" {
                albumsView()
            }else if notification.type == "" {
                collectionView()
            } else {
                homwView()
            }
        }
    }
}

#Preview {
    UnReadNotificationView()
        .environmentObject(NotificationViewModel())
}
