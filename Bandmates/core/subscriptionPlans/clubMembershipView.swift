//
//  clubMembershipView.swift
//  Bandmates
//
//  Created by Mac mini on 15/03/2026.
//

import SwiftUI

struct clubMembershipView: View {
    @State private var features = [
        "Search & save up to 10 albums",
        "View Top 5 albums on chart",
        "Discover & connect with bandmates"
    ]
    var body: some View {
        VStack(spacing:35) {
            VStack(spacing:20) {
            Text("Features Unlocked")
                .font(.system(size: 22,weight: .semibold))
                featuresrowView
            }
            planDetailsView
            planSubscribeView
        }
    }
}

extension clubMembershipView {
    private var featuresrowView: some View {
        VStack(spacing:20) {
            ForEach(features , id: \.self) { text in
                featuresRowView(text: text)
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
    }
    private var planDetailsView: some View {
        VStack(spacing:10) {
            Text("Start Listening Free")
                .font(.system(size: 22,weight: .semibold))
            Text("$0.00")
                .font(.system(size: 28,weight: .bold))
                .foregroundStyle(Color.background)
            Text("Current Plan")
                .font(.system(size: 16,weight: .semibold))
        }
    }
    private var planSubscribeView: some View {
        VStack() {
            Text("Enjoy limited access to discover and organize music\nwith your bandmates. Upgrade anytime to unlock\nmore features!")
                .font(.system(size: 13,weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundStyle(.gray)
            buttonView(action: {}, buttonText: "Keep Using Free Plan", height: 55)
                .padding()

        }
    }
}

#Preview {
    clubMembershipView()
}
