//
//  NotifiCationsView.swift
//  Bandmates
//
//  Created by Mac mini on 30/03/2026.
//

import SwiftUI
enum NotificationsTabs: CaseIterable {
    case allNotifications, unreadNotifications, readedNotifications

    var title: String {
        switch self {
        case .allNotifications:    return "All"
        case .unreadNotifications: return "Unread"
        case .readedNotifications: return "Read"
        }
    }

    var index: Int {
        NotificationsTabs.allCases.firstIndex(of: self) ?? 0
    }
}

struct NotifiCationsView: View {
    @State private var selectedTab: NotificationsTabs = .allNotifications
    @State private var scrollPosition: NotificationsTabs? = .allNotifications
    @EnvironmentObject private var Nvm: NotificationViewModel
    private func countFor(_ tab: NotificationsTabs) -> Int {
        switch tab {
        case .allNotifications:    return Nvm.Notifications?.count ?? 0
        case .unreadNotifications: return Nvm.UnReadNotifications?.count ?? 0
        case .readedNotifications: return Nvm.readedNotifications?.count ?? 0
        }
    }
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack(spacing: 15) {

                // MARK: - Tab Header
                HStack(spacing: 0) {
                    ForEach(NotificationsTabs.allCases, id: \.self) { tab in
                        Button {
                            withAnimation(.easeInOut) {
                                selectedTab = tab
                                scrollPosition = tab
                            }
                        } label: {
                            VStack(spacing: 15) {
                                Text(tab.title + "(\(countFor(tab)))")
                                    .font(.dmSans(15, weight: .semiBold))
                                    .foregroundStyle(selectedTab == tab ? Color.pink : Color.gray)

                                Divider()
                                    .overlay {
                                        Rectangle()
                                            .fill(selectedTab == tab ? Color.pink : Color.clear)
                                            .frame(width:70,height: 2)
                                    }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                }
                .padding(.horizontal)
                .background(Color.white)
               
             
                // MARK: - Paging ScrollView
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 0) {
                        ForEach(NotificationsTabs.allCases, id: \.self) { tab in
                            Group {
                                switch tab {
                                case .allNotifications:
                                    allNotificationView()
                                        .environmentObject(Nvm)
                                case .unreadNotifications: UnReadNotificationView()
                                        .environmentObject(Nvm)
                                case .readedNotifications: ReadedNotificationView()
                                        .environmentObject(Nvm)
                                }
                            }
                            .frame(maxHeight: .infinity)
                            .containerRelativeFrame(.horizontal, alignment: .center)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollPosition(id: $scrollPosition)
                .scrollTargetBehavior(.paging)
                .scrollBounceBehavior(.basedOnSize)
                .ignoresSafeArea(edges: .bottom)
                .onChange(of: scrollPosition) { _, newValue in
                    if let newValue {
                        withAnimation(.easeInOut) {
                            selectedTab = newValue
                        }
                    }
                }
            }
        }.environmentObject(Nvm)
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    NotifiCationsView()
        .environmentObject(NotificationViewModel())
}
