//
//  BandmatesHeaderButtons.swift
//  Bandmates
//
//  Created by Mac mini on 23/03/2026.
//

import SwiftUI

struct BandmatesHeaderButtons: View {
    let tab: BandmatesviewTabs
    let isSelected: Bool
    let action: () -> Void
    let height: CGFloat
    let cornerRadius: CGFloat
    var body: some View {
        Button {
            action()
        } label: {
            Text(tab.title.capitalized)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(isSelected ? .white : .black)
                .frame(maxWidth: .infinity)
                .frame(height: height)
        }
        .background(isSelected ? Color.background : Color.textfieldcolor)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))

    }
}

#Preview {
    BandmatesHeaderButtons(tab: BandmatesviewTabs.discover, isSelected: true, action: {}, height: 38, cornerRadius: 16)
}
