//
//  tabView.swift
//  Bandmates
//
//  Created by Mac mini on 18/03/2026.
//

import SwiftUI
enum AppTab: Int, CaseIterable {
    case home, collection, charts, profile
 
    var title: String {
        switch self {
        case .home:       return "Home"
        case .collection: return "Collection"
        case .charts:     return "Charts"
        case .profile:    return "Profile"
        }
    }
 
    var icon: String {
        switch self {
        case .home:       return "house.fill"
        case .collection: return "square.grid.2x2.fill"
        case .charts:     return "chart.bar.fill"
        case .profile:    return "person.fill"
        }
    }
}
struct tabView: View {
    @State private var selectedTab: AppTab = .home

    var body: some View {
                VStack(spacing: 0) {
                    ZStack {
                        switch selectedTab {
                        case .home:       homwView()
                        case .collection: collectionView()
                        case .charts:     chartView()
                        case .profile:    profileView()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    Divider()
                        .opacity(0.2)
                    
                    // Custom Tab Bar
                    CustomTabBar(selectedTab: $selectedTab)
                }
                .ignoresSafeArea(edges: .bottom)
                .toolbar {
                    ToolbarItem(placement:.topBarLeading) {
                        toolBarMenuButton(action: {print("tool bar menu button")})
                    }.sharedBackgroundVisibility(.hidden)
                    ToolbarItem {
                        Text(toolBarText())
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.background)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }.sharedBackgroundVisibility(.hidden)
                    if selectedTab == .home {
                        ToolbarItem {
                            homeViewNotificationButton(action: {}, notificationCount: 5)

                        }.sharedBackgroundVisibility(.hidden)
                    }
                }
            }
        
    private func toolBarText() -> String {
        if selectedTab == .home {
            return "Bandmates"
        } else if selectedTab == .charts {
            return "Chart"
        } else if selectedTab == .profile {
                return "Profile"
            } else if selectedTab == .collection {
                return "Collection"
            }
        return "Bandmates"
    }
}
#Preview {
    tabView()
}
