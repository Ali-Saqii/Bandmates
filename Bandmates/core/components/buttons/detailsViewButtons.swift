//
//  detailsViewButtons.swift
//  Bandmates
//
//  Created by Mac mini on 24/03/2026.
//

import SwiftUI

struct detailsViewButtons: View {
    let icon1: String
    let icon2 : String
    let title : String
    let action: () -> Void
    let isSelected: Bool
    var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing:5) {
                Image(systemName:isSelected ? icon2 : icon1)
                    .foregroundStyle(isSelected ? Color.background :.black.opacity(0.5))
                    .font(.title3)
                Text(title)
                    .foregroundStyle(isSelected ? Color.background :.black.opacity(0.5))
                    .font(.dmSans(12, weight: .regular))
            }
        }
    }
}

#Preview {
    detailsViewButtons(icon1:  "heart", icon2:  "heart.fill", title: "save", action: {}, isSelected: true)
}
