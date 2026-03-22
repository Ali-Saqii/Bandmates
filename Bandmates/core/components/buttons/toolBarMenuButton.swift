//
//  toolBarMenuButton.swift
//  Bandmates
//
//  Created by Mac mini on 19/03/2026.
//

import SwiftUI

struct toolBarMenuButton: View {
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Image("Menu")
                .background(
                    Circle()
                        .fill(Color.textfieldcolor)
                        .frame(width: 45, height: 45)
                        
                )
        }
    }
}

#Preview {
    toolBarMenuButton(action: {print("Toolbar button")})
}
