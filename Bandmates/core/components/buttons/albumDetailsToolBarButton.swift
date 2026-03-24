//
//  albumDetailsToolBarButton.swift
//  Bandmates
//
//  Created by Mac mini on 25/03/2026.
//

import SwiftUI

struct albumDetailsToolBarButton: View {
    let action: () -> Void
    let iconName: String
    var body: some View {
        Image(systemName: iconName)
            .font(.callout.bold())
            .foregroundStyle(.white)
            .frame(width: 40, height: 40)
            .background(
                Circle()
                    .fill(Color.black.opacity(0.7))
            )
            .onTapGesture {
                action()
            }
    }
}

#Preview {
    albumDetailsToolBarButton(action: {}, iconName: "chevron.left")
}
