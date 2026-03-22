//
//  arenasubscriptionView.swift
//  Bandmates
//
//  Created by Mac mini on 15/03/2026.
//

import SwiftUI

struct arenasubscriptionView: View {
    @State private var features = [
        "Search & save up to 25 albums",
        "View Top 25 albums on chart",
        "Discover & connect with bandmates",
        "Share albums with other users",
        "View comments on saved albums"
    ]
    @State private var isMonthly = true
    @State private var isAnnually = false
    var body: some View {
        VStack(spacing:35)  {
            VStack(spacing:20) {
            Text("Features Unlocked")
                .font(.system(size: 22,weight: .semibold))
                arenaFeaturesrowView
            }
            seletingPlansButtonsView
            arenPlanSubscribeView
            
        }
    }
}
extension arenasubscriptionView {
    private var arenaFeaturesrowView: some View {
        VStack(spacing:20) {
            ForEach(features , id: \.self) { text in
                featuresRowView(text: text)
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
    }
    private var seletingPlansButtonsView: some View {
        VStack (spacing:25) {
            SubscriptionPackageButton(title: "monthly package".capitalized, price: "$2.99", period: "Month", isSelected: isMonthly, action: {
                withAnimation(.easeIn) {
                    isMonthly = true
                    isAnnually = false
                }
            })
            SubscriptionPackageButton(title: "Yearly Package".capitalized, price: "$19.99", period: "Year", isSelected: isAnnually, action: {
                withAnimation(.easeIn) {
                    isMonthly = false
                    isAnnually = true
                }
            })
        }.padding(.horizontal)
    }
    private var arenPlanSubscribeView: some View {
        VStack() {
            Text("Start exploring deeper connections and richer\nmusic experiences. Perfect for casual users who\nwant more freedom!")
                .font(.system(size: 13,weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundStyle(.gray)
            buttonView(action: {}, buttonText: "Upgrade to Arena", height: 55)
                .padding()

        }
    }
}
#Preview {
    arenasubscriptionView()
}
