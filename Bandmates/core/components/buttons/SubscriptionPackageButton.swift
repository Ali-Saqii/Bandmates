//
//  SubscriptionPackageButton.swift
//  Bandmates
//
//  Created by Mac mini on 14/03/2026.
//

import SwiftUI
struct SubscriptionPackageButton: View {
    let title: String       // e.g. "Monthly Package"
    let price: String       // e.g. "$2.99"
    let period: String      // e.g. "/Month"
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(title)
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity,alignment: .leading)
                HStack(spacing:3) {
                    Text(price)
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                    Text("/ "+period)
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }.foregroundStyle(isSelected ? .white : .background)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .overlay {
                Rectangle()
                    .stroke(Color.background,lineWidth: 1)
            }
        }
        .background(isSelected ? Color.background : Color.white)
    }
}
#Preview {
    SubscriptionPackageButton(title:"Monthly Package", price: "$34", period: "month", isSelected: false, action: {})
}
