//
//  UnReadNotificationView.swift
//  Bandmates
//
//  Created by Mac mini on 30/03/2026.
//

import SwiftUI

struct UnReadNotificationView: View {
    @EnvironmentObject var nvm : NotificationViewModel
    @StateObject var vm = HomeViewModel()
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
                                    .onTapGesture {
                                        selectedNotification = notification
                                        print("\(notification)")
                                        Task {
                                            await nvm.markAsRead(notification)
                                        }
                                    }
                                    .padding(.horizontal)
                                    
                                    
                                Divider()
                            }
                        }
                    }.scrollIndicators(.hidden)
                            .scrollBounceBehavior(.basedOnSize)
                } else {
                    NoBandmatesView(icon: "checkmark.circle.fill", height: 70, width: 70, title: "No Unreads!", subTitle: "You have no unreaded notifications notifications at the moment. Check back later for updates!", titleFont: .dmSans(20, weight: .semiBold), subTitleFont: .dmSans(14, weight: .medium), color: Color.background.opacity(0.3))
                }
            
        }.navigationDestination(item: $selectedNotification) { notification in
            if notification.type == "bandmate_activity" {
                Bandmates()
                    .environmentObject(vm)
            }else if notification.type == "comment" {
                albumsView()
                    .environmentObject(vm)
            }else if notification.type == "collection_update'" {
                collectionView()
                    .environmentObject(vm)
            } else {
                AppTabView()
                    .environmentObject(vm)
            }
        }
    }
}

#Preview {
    UnReadNotificationView()
        .environmentObject(NotificationViewModel())
}
