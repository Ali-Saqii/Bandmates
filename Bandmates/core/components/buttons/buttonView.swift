//
//  buttonView.swift
//  Bandmates
//
//  Created by Mac mini on 13/03/2026.
//

import SwiftUI

struct buttonView: View {
    let action: () -> Void
    let buttonText: String
    let height: CGFloat
    var body: some View {
        Button {
            action()
        } label: {
            Text(buttonText.capitalized)
                .foregroundStyle(.white)
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity)
                .frame(height: height)
        }.background(Color("backgroundColor"))
            .cornerRadius(30)

    }
}

#Preview {
    buttonView(action: {}, buttonText: "Sign In", height: 60)
   
}
