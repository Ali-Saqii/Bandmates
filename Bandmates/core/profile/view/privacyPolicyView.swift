//
//  privacyPolicyView.swift
//  Bandmates
//
//  Created by Mac mini on 29/03/2026.
//

import SwiftUI

struct privacyPolicyView: View {
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
                    
                    // MARK: How We Use Your Information
                    LegalSectionView(
                        title: "How We Use Your Information?",
                        content: nil,
                        bulletPoints: [
                            "To Provide And Improve Our Services.",
                            "To Process Payments And Fulfill Orders.",
                            "To Communicate With You, Including Sending Service-Related Updates, Marketing Communications (If You Have Consented), And Customer Support."
                        ]
                    )
                    
                    // MARK: Security
                    LegalSectionView(
                        title: "Security",
                        content: """
                            We Implement Reasonable Measures To Protect Your Personal Information. However, No Method Of Transmission Over The Internet Is Completely Secure, And We Cannot Guarantee The Security Of Your Information.
                            """
                    )
                    
                    // MARK: Information We Collect
                    LegalSectionView(
                        title: "Information We Collect",
                        content: "We Collect The Following Types Of Information:",
                        bulletPoints: [
                            "Personal Information: When You Register For An Account, Place An Order, Or Communicate With Us, We May Collect Personal Information Such As Your Name, Email Address, Phone Number, Mailing Address, And Payment Details.",
                            "Usage Data: We Collect Data On How You Access And Use Our Website, Including Your IP Address, Browser Type, Device Type, And Activity On Our Site.",
                            "Cookies And Tracking Technologies: We Use Cookies And Similar Technologies To Enhance Your Experience, Analyze Usage, And Improve Our Services."
                        ]
                    )
                    
                    // MARK: Information We Collect (continued)
                    LegalSectionView(
                        title: "Information We Collect",
                        content: "We Collect The Following Types Of Information:",
                        bulletPoints: [
                            "Personal Information: When You Register For An Account, Place An Order, Or Communicate With Us."
                        ]
                    )
                    
                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 24)
            }
            .background(Color(.systemBackground))
            .navigationTitle("Privacy Policy")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}
#Preview {
    privacyPolicyView()
}
