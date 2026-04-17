//
//  featuresRowView.swift
//  Bandmates
//
//  Created by Mac mini on 15/03/2026.
//

import SwiftUI

struct featuresRowView: View {
    let text : String
    var body: some View {
        HStack {
            Circle()
                .fill(Color.background)
                .frame(width: 17, height: 17)
                .overlay {
                    Image(systemName: "checkmark")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
            Text(text)
                .font(.system(size: 15))
        }
    }
}

#Preview {
    featuresRowView(text: "fjjh fjfhjhf dsfhjdfh")
}
