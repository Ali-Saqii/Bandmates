//
//  IllustrationView.swift
//  Bandmates
//
//  Created by Mac mini on 13/03/2026.
//

import SwiftUI

struct IllustrationView: View {
    let symbolName: String
    var body: some View {
        ZStack {
            Image(symbolName)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color.brandPink, Color.brandPink.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        }
    }
}

#Preview {
    IllustrationView(symbolName: "page1logo")
}
