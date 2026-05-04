//
//  NotificationSettinfView.swift
//  Bandmates
//
//  Created by Mac mini on 29/03/2026.
//

import SwiftUI

struct NotificationSettinfView: View {
    @StateObject var nsVM = NotificationSettingsViewModel()
    @EnvironmentObject var pvm : ProfileViewModel
    @State private var enableSystemAnnouncements = false
    @State private var enableBandmateActivity = false
    @State private var enableCommentsNotification = false
    @State private var enableCollectionUpdates = false
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack(spacing: 0) {
                settingRow(
                    title: "System Announcements",
                    isOn: $nsVM.settings.systemAnnouncements,
                    key: "systemAnnouncements"
                )
                Divider()
                settingRow(
                    title: "Bandmate Activity",
                    isOn: $nsVM.settings.bandmateActivity,
                    key: "bandmateActivity"
                )
                Divider()
                settingRow(
                    title: "Comments Notification",
                    isOn: $nsVM.settings.commentsNotification,
                    key: "commentsNotification"
                )
                Divider()
                settingRow(
                    title: "Collection Updates",
                    isOn: $nsVM.settings.collectionUpdates,
                    key: "collectionUpdates"
                )
                Spacer()
            }
            .padding(.top, 20)
        }.navigationTitle("Notification Settings")
            .navigationBarTitleDisplayMode(.inline)
          
    }
    func settingRow(title: String, isOn: Binding<Bool>, key: String) -> some View {
        HStack {
            Text(title)
                .font(.dmSans(16, weight: .semiBold))
                .foregroundColor(.black)
            Spacer()
            Toggle("", isOn: isOn)
                .labelsHidden()
                .scaleEffect(0.7)
                .tint(Color.background)
                .onChange(of: isOn.wrappedValue) { _, newValue in
                    nsVM.updateSetting(key: key, value: newValue)
                }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}


#Preview {
    NotificationSettinfView()
        .environmentObject(ProfileViewModel())
}
