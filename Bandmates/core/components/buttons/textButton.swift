//
//  textButton.swift
//  Bandmates
//
//  Created by Mac mini on 13/03/2026.
//

import SwiftUI

struct textButton: View {
    let action: () -> Void
    let text: String
    let color: Color
    let textSize: CGFloat
    var body: some View {
        
        Button {
            action()
        } label: {
            Text(text)
                .font(.system(size:textSize, weight: .medium))
                .foregroundColor(color)
        }
    }
}

#Preview {
    textButton(action: {}, text: "Sign Up", color: .background, textSize: 16)
}
