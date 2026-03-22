//
//  stadiumSubscriptionView.swift
//  Bandmates
//
//  Created by Mac mini on 15/03/2026.
//

import SwiftUI

struct stadiumSubscriptionView: View {
    @State private var stadiumIsMonthly = true
    @State private var stadiumIsAnnually = false
    @State private var features = [
        "Save unlimited number of albums",
        "View all ranking albums on chart",
        "Discover and connect with bandmates",
        "Share albums with other users",
        "View & add comments on saved albums"
    ]
    var body: some View {
        VStack(spacing:35)  {
            VStack(spacing:20) {
            Text("Features Unlocked")
                .font(.system(size: 22,weight: .semibold))
                stadiumFeaturesrowView
            }
            seletingPlansButtonsView
            stadiumPlanSubscribeView
        }
    }
}
extension stadiumSubscriptionView {
    private var stadiumFeaturesrowView: some View {
        VStack(spacing:20) {
            ForEach(features , id: \.self) { text in
                featuresRowView(text: text)
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
    }
    private var seletingPlansButtonsView: some View {
        VStack (spacing:25) {
            SubscriptionPackageButton(title: "monthly package".capitalized, price: "$7.99", period: "Month", isSelected: stadiumIsMonthly, action: {
                withAnimation(.easeIn) {
                    stadiumIsMonthly = true
                    stadiumIsAnnually = false
                }
            })
            SubscriptionPackageButton(title: "Yearly Package".capitalized, price: "$59.99", period: "Year", isSelected: stadiumIsAnnually, action: {
                withAnimation(.easeIn) {
                    stadiumIsMonthly = false
                    stadiumIsAnnually = true
                }
            })
        }.padding(.horizontal)
    }
    private var stadiumPlanSubscribeView: some View {
        VStack() {
            Text("Unlock the full experience with unlimited access\nand powerful features. Ideal for passionate users\nready to dive all in!")
                .font(.system(size: 13,weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundStyle(.gray)
            buttonView(action: {}, buttonText: "Upgrade to Stadium", height: 55)
                .padding()

        }
    }
}
#Preview {
    stadiumSubscriptionView()
}
