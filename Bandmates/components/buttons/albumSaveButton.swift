//
//  albumSaveButton.swift
//  Bandmates
//
//  Created by Mac mini on 20/03/2026.
//

import SwiftUI

struct albumSaveButton: View {
    let isSaved: Bool
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName:isSaved ? "heart.fill" : "heart")
                .foregroundStyle(isSaved ? Color.background:Color.gray)
                .background(
                    Circle()
                        .fill(.textfieldcolor.opacity(0.5))
                        .frame(width: 30, height: 30)
                )
        }

    }
}

#Preview {
    albumSaveButton(isSaved:true, action: {})
}
