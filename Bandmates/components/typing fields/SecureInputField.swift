//
//  SecureInputField.swift
//  Bandmates
//
//  Created by Mac mini on 13/03/2026.
//

import SwiftUI

struct SecureInputField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.black)
            ZStack(alignment:.trailing) {
                SecureField(placeholder, text: $text)
                    .keyboardType(.default)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .font(.callout)
                    .foregroundColor(.black.opacity(0.7))
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
}
#Preview {
    SecureInputField(label: "gdfgdf", placeholder: "fgdgdf", text: .constant("dfsfsfd"))
}
