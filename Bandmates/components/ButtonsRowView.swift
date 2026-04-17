//
//  ButtonsRowView.swift
//  Bandmates
//
//  Created by Mac mini on 28/03/2026.
//

import SwiftUI

struct ButtonsRowView: View {
    let icon: String
    let title: String
    let text: String
    let color : Color
    let action: () -> Void
    var body: some View {
            HStack {
                Image(icon)
                    .resizable()
                    .frame(width: 18, height: 19)
                    .foregroundStyle(color)
                Text(title)
                    .font(.dmSans(15, weight: .semiBold))
                    .foregroundStyle(color)
                Spacer()
                Text(text)
                    .font(.dmSans(16, weight: .medium))
                    .foregroundStyle(Color.background)
                Image(systemName: "chevron.forward")
                    .foregroundStyle(.black.opacity(0.7))
                    .fontWeight(.bold)
                
            }
            .overlay(content: {
                Rectangle()
                    .fill(.white.opacity(0.1))
            })
            .onTapGesture {
                action()
            }
            .padding(.horizontal)
        }
    }

#Preview {
    ButtonsRowView(icon:"star", title:  "Billig and subscription", text: "private", color: .red, action: {print("taped")})
}
