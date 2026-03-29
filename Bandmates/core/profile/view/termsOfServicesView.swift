//
//  termsOfServicesView.swift
//  Bandmates
//
//  Created by Mac mini on 29/03/2026.
//

import SwiftUI

struct termsOfServicesView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    
                    // MARK: Introduction
                    LegalSectionView(
                        title: "Introduction",
                        content: """
                        We are committed to protecting your privacy. This privacy policy explains how we collect, use, disclose, safeguard your information when you visit our website, use our services, or engage with us in other ways. Please read this policy carefully.
                        """
                    )
                    
                    // MARK: Use Of Our Services
                    LegalSectionView(
                        title: "Use Of Our Services",
                        content: "License: We Grant You A Limited, Non-Exclusive, Non-Transferable License To Access And Use Our Website For Personal, Non-Commercial Purposes In Accordance With These Terms.",
                        bulletPoints: [
                            "Hacking, Spamming, Or Transmitting Malware.",
                            "Using The Website To Infringe On Any Intellectual Property Rights.",
                            "Engaging In Fraudulent Activities."
                        ],
                        bulletHeader: "Prohibited Activities: You Agree Not To Engage In Any Unlawful, Harmful, Or Disruptive Activities, Including But Not Limited To:"
                    )
                    
                    // MARK: Account
                    LegalSectionView(
                        title: "Account",
                        content: """
                        To Use Certain Services, You May Need To Create An Account. You Are Responsible For Maintaining The Confidentiality Of Your Account Credentials And For All Activities That Occur Under Your Account.
                        """
                    )
                    
                    // MARK: Payment And Billing
                    LegalSectionView(
                        title: "Payment And Billing",
                        content: """
                        If You Make A Purchase Through Our Website, You Agree To Provide Accurate Payment Information. We Reserve The Right To Refuse Or Cancel Any Orders For Reasons Such As Product Availability, Errors In Pricing, Or Fraud Detection.
                        """
                    )
                    
                    // MARK: Use Of Our Services (2nd)
                    LegalSectionView(
                        title: "Use Of Our Services",
                        content: "License: We Grant You A Limited, Non-Exclusive, Non-Transferable License To Access And Use Our Website For Personal, Non-Commercial Purposes In Accordance With These Terms.",
                        bulletPoints: [
                            "Hacking, Spamming, Or Transmitting Malware.",
                            "Using The Website To Infringe On Any Intellectual Property Rights.",
                            "Engaging In Fraudulent Activities."
                        ],
                        bulletHeader: "Prohibited Activities: You Agree Not To Engage In Any Unlawful, Harmful, Or Disruptive Activities, Including But Not Limited To:"
                    )
                    
                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 24)
            }
            .background(Color(.systemBackground))
            .navigationTitle("Term of Services")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
#Preview {
    termsOfServicesView()
}
