//
//  arenasubscriptionView.swift
//  Bandmates
//
//  Created by Mac mini on 15/03/2026.
//

import SwiftUI

struct arenasubscriptionView: View {
    @EnvironmentObject var avm: AuthViewModel
    @State private var features = [
        "Search & save up to 25 albums",
        "View Top 25 albums on chart",
        "Discover & connect with bandmates",
        "Share albums with other users",
        "View comments on saved albums"
    ]
    @State private var isMonthly = true
    @State private var isAnnually = false
    private var isNewUser: Bool {
         avm.user?.subscriptionPlan == "club" && avm.user?.isOnTrial == false
     }

     private var buttonText: String {
         isNewUser ? "Start 14-Day Free Trial" : "Upgrade to Arena"
     }
    
    private var selectedPlan: String {
           isMonthly ? "arena_monthly" : "arena_annual"
       }
    var body: some View {
        VStack(spacing:35)  {
            VStack(spacing:20) {
            Text("Features Unlocked")
                .font(.system(size: 22,weight: .semibold))
                arenaFeaturesrowView
            }
            seletingPlansButtonsView
            arenPlanSubscribeView
            
        }.navigationDestination(isPresented: $avm.isSubscribe) {
            subscriptionDetailsAndManageView( nameOfSubscriptionPlan: avm.subscriptionData?.membership ?? "", price: "", Status: "Active", dateOfSubscription: .now, nextBillingDate: avm.subscriptionData?.subscriptionEndsAt ?? .now)
                .environmentObject(avm)
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
            buttonView(action: {
                avm.selectPlan(plan:selectedPlan )
            }, buttonText: buttonText, height: 55)
                .padding()

        }
    }
}
#Preview {
    arenasubscriptionView()
        .environmentObject(AuthViewModel())
}
