//
//  strokeButtonView.swift
//  Bandmates
//
//  Created by Mac mini on 13/03/2026.
//

import SwiftUI

struct strokebuttonView: View {
    let action: () -> Void
    let buttonText: String
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(buttonText)
                .foregroundStyle(Color("backgroundColor"))
                .font(.callout)
                .bold()
                .frame(maxWidth: .infinity)
                .frame(height: 45)
        }.background(
            RoundedRectangle(cornerRadius: 30)
                .stroke(lineWidth: 2)
                .fill(Color("backgroundColor"))
        )
    }
}

#Preview {
    strokebuttonView(action: {}, buttonText: "create an account")
}
