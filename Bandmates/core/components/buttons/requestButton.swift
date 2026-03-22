//
//  requestButton.swift
//  Bandmates
//
//  Created by Mac mini on 20/03/2026.
//

import SwiftUI

struct requestButton: View {
    let title: String
    let title2: String
    let action: () -> Void
    let height: CGFloat
    let width: CGFloat
    let font: Font
    let cornerRadius: CGFloat
    let isRequested: Bool
    var body: some View {
        Button {
            action()
        } label: {
            Text(isRequested ? title2 :title)
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(height: height)
                .frame(width: width)
        }.background(isRequested ? Color.gray.opacity(0.8) : Color.background)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))

    }
}

#Preview {
    requestButton(title: "requested", title2: "Waiting to Jam", action: {}, height: 30, width: 100, font: .caption2, cornerRadius: 25, isRequested: true)
}
