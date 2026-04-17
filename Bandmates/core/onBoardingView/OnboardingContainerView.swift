//
//  OnboardingContainerView.swift
//  Bandmates
//
//  Created by Mac mini on 13/03/2026.
//

import SwiftUI

struct OnboardingContainerView: View {
    let pages: [OnboardingPage]
    @Binding var currentPage: Int
    @Binding var showLogin: Bool
    @Binding var showSignUp: Bool
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    crossButton(action: {
                        withAnimation {
                            showLogin = true
                        }
                    })
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)

                TabView(selection: $currentPage) {
                    ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                        OnboardingPageView(page: page)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentPage)

                HStack(spacing: 8) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Capsule()
                            .fill(index == currentPage ? Color.brandPink : Color.inputBorder)
                            .frame(width: index == currentPage ? 20 : 8, height: 8)
                            .animation(.spring(response: 0.3), value: currentPage)
                    }
                }
                .padding(.bottom, 32)

                // Buttons
                VStack(spacing: 14) {
                    buttonView(action:{
                        withAnimation {
                            showLogin = true
                        }
                    }, buttonText: "Sign in", height: 55)
                    strokebuttonView(action: {
                        withAnimation {
                            showSignUp = true
                        }
                    }, buttonText: "Create an Account")
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    OnboardingContainerView(pages: [
        OnboardingPage(illustration: "page2logo", title: "dfjhfjds", subtitle: "dshfgd dsgfhdgsf dsghdsfhd fdghgfd"),
        OnboardingPage(illustration: "page2logo", title: "dfjhfjds", subtitle: "dshfgd dsgfhdgsf dsghdsfhd fdghgfd"),
        OnboardingPage(illustration: "page2logo", title: "dfjhfjds", subtitle: "dshfgd dsgfhdgsf dsghdsfhd fdghgfd")
    ], currentPage: .constant(1), showLogin: .constant(false), showSignUp:.constant(false))
}
