//
//  stadiumSubscriptionView.swift
//  Bandmates
//
//  Created by Mac mini on 15/03/2026.
//

import SwiftUI

struct stadiumSubscriptionView: View {
    @EnvironmentObject var avm: AuthViewModel
    @State private var stadiumIsMonthly = true
    @State private var stadiumIsAnnually = false
    @State private var features = [
        "Save unlimited number of albums",
        "View all ranking albums on chart",
        "Discover and connect with bandmates",
        "Share albums with other users",
        "View & add comments on saved albums"
    ]
    private var isNewUser: Bool {
         avm.user?.subscriptionPlan == "club" && avm.user?.isOnTrial == false
     }

     private var buttonText: String {
         isNewUser ? "Start 14-Day Free Trial" : "Upgrade to Stadium"
     }
    private var selectedPlan: String {
        stadiumIsMonthly ? "stadium_monthly" : "stadium_annual"
       }
    var body: some View {
        VStack(spacing:35)  {
            VStack(spacing:20) {
            Text("Features Unlocked")
                .font(.system(size: 22,weight: .semibold))
                stadiumFeaturesrowView
            }
            seletingPlansButtonsView
            stadiumPlanSubscribeView
        }.navigationDestination(isPresented: $avm.isSubscribe) {
            subscriptionDetailsAndManageView( nameOfSubscriptionPlan: avm.subscriptionData?.membership ?? "", price: "", Status: "Active", dateOfSubscription: .now, nextBillingDate: avm.subscriptionData?.subscriptionEndsAt ?? .now)
                .environmentObject(avm)
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
            buttonView(action: {
                avm.selectPlan(plan:selectedPlan )
            }, buttonText: buttonText, height: 55)
                .padding()

        }
    }
}
#Preview {
    stadiumSubscriptionView()
        .environmentObject(AuthViewModel())
}
