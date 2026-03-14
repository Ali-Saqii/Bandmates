//
//  InputField.swift
//  Bandmates
//
//  Created by Mac mini on 13/03/2026.
//

import SwiftUI

struct InputField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.black.opacity(1))

            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .disableAutocorrection(true)
                .font(.callout)
                .foregroundStyle(.black.opacity(0.7))
                .padding(.horizontal, 14)
                .frame(height: 50)
                .background(.textfieldcolor.opacity(0.3))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.textfieldcolor, lineWidth: 1)
                )
        }
    }
}

#Preview {
    InputField(label: "dsfdsf", placeholder: "fdsfsd", text: .constant("dsfds"))
}
