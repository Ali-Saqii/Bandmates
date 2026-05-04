//
//  NotificationSettinfView.swift
//  Bandmates
//
//  Created by Mac mini on 29/03/2026.
//

import SwiftUI

struct NotificationSettinfView: View {
    @EnvironmentObject var pvm : ProfileViewModel
    @State private var enableSystemAnnouncements = false
    @State private var enableBandmateActivity = false
    @State private var enableCommentsNotification = false
    @State private var enableCollectionUpdates = false
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack(spacing:30) {
                Divider()
                HStack {
                    Text("System Announcements")
                        .foregroundStyle(.black)
                        .font(.dmSans(16, weight: .semiBold))
                    Spacer()
                    Toggle("", isOn: $enableSystemAnnouncements)
                        .tint(Color.background)
                        .scaleEffect(0.8)
                        .frame(width: 44, height: 28)
                }
                HStack {
                    Text("Bandmate Activity")
                        .foregroundStyle(.black)
                        .font(.dmSans(16, weight: .semiBold))
                    Spacer()
                    Toggle("", isOn: $enableBandmateActivity)
                        .tint(Color.background)
                        .scaleEffect(0.8)
                        .frame(width: 44, height: 28)
                }
                HStack {
                    Text("Comments Notification")
                        .foregroundStyle(.black)
                        .font(.dmSans(16, weight: .semiBold))
                    Spacer()
                    Toggle("", isOn: $enableCommentsNotification)
                        .tint(Color.background)
                        .scaleEffect(0.8)
                        .frame(width: 44, height: 28)
                }
                HStack {
                    Text("Collection Updates")
                        .foregroundStyle(.black)
                        .font(.dmSans(16, weight: .semiBold))
                    Spacer()
                    Toggle("", isOn: $enableCollectionUpdates)
                        .tint(Color.background)
                        .scaleEffect(0.8)
                        .frame(width: 44, height: 28)
                }
                Spacer()
            }.padding(.horizontal)
        }.navigationTitle("Notification Settings")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NotificationSettinfView()
        .environmentObject(ProfileViewModel())
}
