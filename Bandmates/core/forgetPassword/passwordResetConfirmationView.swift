//
//  passwordResetConfirmationView.swift
//  Bandmates
//
//  Created by Mac mini on 14/03/2026.
//

import SwiftUI

struct passwordResetConfirmationView: View {
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea(.all)
            VStack(spacing:40) {
                Image("Successmark")
                Text("Bandmates has emailed your\npassword reset link.Please check your\nemail to confirm.")
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .foregroundStyle(.opacity(0.8))
                    .lineSpacing(0)
                buttonView(action: {}, buttonText: "Done", height: 55)
                    .padding(.horizontal,120)
            }
        }
    }
}

#Preview {
    passwordResetConfirmationView()
}
