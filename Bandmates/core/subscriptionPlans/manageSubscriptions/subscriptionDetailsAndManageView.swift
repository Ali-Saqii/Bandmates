//
//  subscriptionDetailsAndManageView.swift
//  Bandmates
//
//  Created by Mac mini on 15/03/2026.
//

import SwiftUI

struct subscriptionDetailsAndManageView: View {
    @EnvironmentObject var avm: AuthViewModel
    let nameOfSubscriptionPlan: String
    let price: String
    let Status: String
    let dateOfSubscription: Date
    var nextBillingDate: Date
    var body: some View {
        VStack {
            VStack(spacing:25) {
                Text("Thank you for subscribing! Unlock full\naccess and enjoy the ultimate music\nexperience.")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                
                VStack {
                    HStack {
                        Image("stars")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .padding(.leading,10)
                        Spacer()
                        Text("\(nameOfSubscriptionPlan) Membership")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        Spacer()
                    }.frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.background)
                        .clipShape(
                            .rect(
                                topLeadingRadius: 15,
                                topTrailingRadius: 15
                            )
                        )
                    VStack(alignment: .leading,spacing: 15) {
                        HStack {
                            Text("Status:")
                            Text(Status)
                                .foregroundStyle(Color.background)
                        }
                        HStack {
                            Text("Subscription Start Date:")
                            Text("\(dateOfSubscription.billingFormatted)")
                                .foregroundStyle(Color.background)
                        }
                        HStack {
                            Text("Next Billing Date:")
                            Text("\(nextBillingDate.billingFormatted)")
                                .foregroundStyle(Color.background)
                        }
                        
                    }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .padding(.bottom)
                }.background(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black.opacity(0.5), lineWidth: 1)                )
                .padding(.horizontal)
                VStack(spacing:25) {
                    Text("Your subscription will automatically renew at $\(price) monthly unless canceled. Manage your subscription directly below.")
                        .multilineTextAlignment(.center)
                        .lineSpacing(0)
                    buttonView(action: {
                        avm.cancelPlan()
                    }, buttonText: "Cancel Subscription", height: 55).padding(.horizontal,8)
                    if let error = avm.subErrorMessage {
                        Text(error)
                            .font(.dmSans(14, weight: .regular))
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                    }
                    if let message = avm.subSucssMessage {
                        Text(message)
                            .font(.dmSans(14, weight: .regular))
                            .foregroundStyle(.green)
                            .multilineTextAlignment(.center)
                    }
                }.padding(.bottom,45)
            }.padding()
        }.background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(radius: 10)
        )
        .padding()
        .navigationTitle("Manage Subscription")
        Spacer()
    }
}

#Preview {
    subscriptionDetailsAndManageView(nameOfSubscriptionPlan: "stadium Membership".capitalized, price:"7.99", Status: "Active", dateOfSubscription: .now, nextBillingDate: .now)
        .environmentObject(AuthViewModel())
}
