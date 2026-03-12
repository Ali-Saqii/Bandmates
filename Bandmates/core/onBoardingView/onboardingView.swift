//
//  onboardingView.swift
//  Bandmates
//
//  Created by Mac mini on 13/03/2026.
//

import SwiftUI
struct OnboardingPage: Identifiable {
    let id = UUID()
    let illustration: String
    let title: String
    let subtitle: String
}

struct onboardingView: View {
    @State private var showLogin = false
    @State private var currentPage = 0

    let pages: [OnboardingPage] = [
        OnboardingPage(
            illustration: "page1logo",
            title: "Explore & Rate Albums",
            subtitle: "Dive into music like never before. Rate albums, share your thoughts, and see how your friends feel about the same tracks."
        ),
        OnboardingPage(
            illustration: "page2logo",
            title: "Connect with Bandmates",
            subtitle: "Send requests and discover users with similar taste. Build your circle — one album at a time."
        ),
        OnboardingPage(
            illustration: "page3logo",
            title: "Curate Your Collections",
            subtitle: "Save your favorite albums and keep them organized. Your personal library grows with every great find."
        )
    ]

    var body: some View {
        if showLogin {
            LoginView(showLogin: $showLogin)
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing),
                    removal: .move(edge: .leading)
                ))
        } else {
            OnboardingContainerView(
                pages: pages,
                currentPage: $currentPage,
                showLogin: $showLogin
            )
            .transition(.asymmetric(
                insertion: .move(edge: .leading),
                removal: .move(edge: .trailing)
            ))
        }
    }
}
#Preview {
    onboardingView()
}
