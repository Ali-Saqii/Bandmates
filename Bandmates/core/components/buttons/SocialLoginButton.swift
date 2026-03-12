//
//  SocialLoginButton.swift
//  Bandmates
//
//  Created by Mac mini on 13/03/2026.
//

import SwiftUI

struct SocialLoginButton: View {
    let icon: String
    let label: String
    let iconColor: Color

    var body: some View {
        Button {
            // Social login action
        } label: {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(iconColor)
                Text(label)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.textPrimary)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.inputBorder, lineWidth: 1.5)
            )
        }
    }
}
#Preview {
    SocialLoginButton(icon: "apple.fill", label:"Apple", iconColor: .black)
}
