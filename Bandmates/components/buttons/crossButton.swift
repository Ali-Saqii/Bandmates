//
//  crossButton.swift
//  Bandmates
//
//  Created by Mac mini on 13/03/2026.
//

import SwiftUI

struct crossButton: View {
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.textPrimary)
                .padding(10)
                .background(Color(.systemGray6))
                .clipShape(Circle())
        }    }
}

#Preview {
    crossButton(action: {})
}
