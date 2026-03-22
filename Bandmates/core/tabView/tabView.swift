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
            // Page content area
            ZStack {
                switch selectedTab {
                case .home:       homwView()
                case .collection: collectionView()
                case .charts:     chartView()
                case .profile:    profileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
 
            Divider()
                .opacity(0.2)
 
            // Custom Tab Bar
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(edges: .top)
    }
}
 
// MARK: - Custom Tab Bar
struct CustomTabBar: View {
    @Binding var selectedTab: AppTab
 
    var body: some View {
        HStack(spacing: 0) {
            ForEach(AppTab.allCases, id: \.rawValue) { tab in
                TabBarItem(tab: tab, isSelected: selectedTab == tab)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedTab = tab
                        }
                    }
            }
        }
        .padding(.horizontal, 8)
        .padding(.top, 10)
        .padding(.bottom, 24) // safe area padding
        .background(Color(.systemBackground))
    }
}
 
// MARK: - Tab Bar Item
struct TabBarItem: View {
    let tab: AppTab
    let isSelected: Bool
 
    // Accent color matching the screenshot's purple/pink tone
    private let accentColor = Color(red: 0.55, green: 0.25, blue: 0.85)
 
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: tab.icon)
                .font(.system(size: 22, weight: isSelected ? .semibold : .regular))
                .foregroundColor(isSelected ? accentColor : Color(.secondaryLabel))
                .scaleEffect(isSelected ? 1.1 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
 
            Text(tab.title)
                .font(.system(size: 10, weight: isSelected ? .semibold : .regular))
                .foregroundColor(isSelected ? accentColor : Color(.secondaryLabel))
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
    }
}
#Preview {
    tabView()
}
