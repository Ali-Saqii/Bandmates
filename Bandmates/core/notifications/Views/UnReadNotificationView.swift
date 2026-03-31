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
            ScrollView {
                if let allNotifications = nvm.UnReadNotifications {
                    VStack(spacing: 10) {
                        ForEach(allNotifications) { notification in
                                notificationRowView(Notification: notification)
                                    .padding(.horizontal)
                                Divider()
                        }
                    }
                } else {
                    
                }
            }
        }.scrollIndicators(.hidden)
            .scrollBounceBehavior(.basedOnSize)
    }
}


#Preview {
    UnReadNotificationView()
        .environmentObject(NotificationViewModel())
}
