//
//  OnboardingPageView.swift
//  Bandmates
//
//  Created by Mac mini on 13/03/2026.
//

import SwiftUI

struct OnboardingPageView: View {
    let page: OnboardingPage
    @State private var appeared = false

    var body: some View {
        VStack(spacing: 0) {
            // Illustration area
            ZStack {
                IllustrationView(symbolName: page.illustration)
                    .scaleEffect(appeared ? 1.0 : 0.7)
                    .opacity(appeared ? 1 : 0)
                    .animation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.1), value: appeared)
            }
            .padding(.top, 20)
            .padding(.bottom, 40)

            // Text
            VStack(spacing: 12) {
                Text(page.title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.textPrimary)
                    .multilineTextAlignment(.center)
                    .offset(y: appeared ? 0 : 20)
                    .opacity(appeared ? 1 : 0)
                    .animation(.easeOut(duration: 0.5).delay(0.2), value: appeared)

                Text(page.subtitle)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 32)
                    .offset(y: appeared ? 0 : 20)
                    .opacity(appeared ? 1 : 0)
                    .animation(.easeOut(duration: 0.5).delay(0.3), value: appeared)
            }

            Spacer()
        }
        .onAppear {
            appeared = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                appeared = true
            }
        }
        .onDisappear {
            appeared = false
        }
    }
}
#Preview {
    OnboardingPageView(page: OnboardingPage(illustration: "page2logo", title: "dfjhfjds", subtitle: "dshfgd dsgfhdgsf dsghdsfhd fdghgfd"))
}
