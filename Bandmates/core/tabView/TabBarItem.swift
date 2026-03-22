//
//  TabBarItem.swift
//  Bandmates
//
//  Created by Mac mini on 19/03/2026.
//

import SwiftUI

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

