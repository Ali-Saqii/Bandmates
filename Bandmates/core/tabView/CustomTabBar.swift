//
//  CustomTabBar.swift
//  Bandmates
//
//  Created by Mac mini on 19/03/2026.
//

import SwiftUI

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
        .padding(.top, 15)
        .padding(.bottom, 15)
        // safe area padding
        .background(Color(.white))
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}
