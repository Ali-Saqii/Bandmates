//
//  LegalSectionView.swift
//  Bandmates
//
//  Created by Mac mini on 29/03/2026.
//

import SwiftUI

// MARK: - Brand Colors
extension Color {
    /// Bandmate primary accent – vivid pink-red
    static let bandmateAccent = Color(red: 1.0, green: 0.20, blue: 0.40)

    /// Light tint used for section-title underline pill
    static let bandmateAccentLight = Color(red: 1.0, green: 0.20, blue: 0.40).opacity(0.12)

    /// Subtle divider / separator
    static let legalDivider = Color(.separator).opacity(0.5)

    /// Body text colour – slightly softened
    static let legalBody = Color(.secondaryLabel)
}

// MARK: - Reusable Legal Section
/// Drop this wherever you need a titled block of legal copy with optional bullet points.
struct LegalSectionView: View {
    let title: String
    var content: String?
    var bulletPoints: [String]?
    /// Optional lead-in sentence before bullet list
    var bulletHeader: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            // ── Section Title ──
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)

                // Accent underline
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.bandmateAccent)
                    .frame(width: 32, height: 2.5)
            }

            // ── Body Paragraph ──
            if let content {
                Text(content)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(Color.legalBody)
                    .lineSpacing(5)
                    .fixedSize(horizontal: false, vertical: true)
            }

            // ── Optional bullet-header sentence ──
            if let bulletHeader {
                Text(bulletHeader)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(Color.legalBody)
                    .lineSpacing(5)
                    .fixedSize(horizontal: false, vertical: true)
            }

            // ── Bullet Points ──
            if let bulletPoints {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(bulletPoints, id: \.self) { point in
                        HStack(alignment: .top, spacing: 10) {
                            // Dot
                            Circle()
                                .fill(Color.bandmateAccent)
                                .frame(width: 5, height: 5)
                                .padding(.top, 6)

                            Text(point)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(Color.legalBody)
                                .lineSpacing(5)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
                .padding(.leading, 4)
            }

            // ── Bottom Divider ──
            Divider()
                .background(Color.legalDivider)
                .padding(.top, 4)
        }
    }
}

// MARK: - Preview
#Preview("Legal Section") {
    ScrollView {
        VStack(spacing: 28) {
            LegalSectionView(
                title: "Introduction",
                content: "We are committed to protecting your privacy. This policy explains how we collect and use your data."
            )
            LegalSectionView(
                title: "How We Use Your Information?",
                bulletPoints: [
                    "To Provide And Improve Our Services.",
                    "To Process Payments And Fulfill Orders.",
                    "To Communicate With You, Including Sending Updates."
                ]
            )
            LegalSectionView(
                title: "Use Of Our Services",
                content: "License: We Grant You A Limited, Non-Exclusive License.",
                bulletPoints: [
                    "Hacking, Spamming, Or Transmitting Malware.",
                    "Using The Website To Infringe On Any Intellectual Property Rights."
                ],
                bulletHeader: "Prohibited Activities: You Agree Not To Engage In Any Unlawful Activities, Including But Not Limited To:"
            )
        }
        .padding()
    }
}
