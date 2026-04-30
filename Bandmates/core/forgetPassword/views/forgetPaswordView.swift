//
//  forgetPaswordView.swift
//  Bandmates
//
//  Created by Mac mini on 14/03/2026.
//

import SwiftUI

struct forgetPaswordView: View {
    @StateObject private var fVM = ForgotPasswordViewModel()
    @State private var showSucessView = false
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea(.all)
            VStack(spacing: 40) {
                VStack(alignment: .leading) {
                    Text("Forget Password?")
                        .fontDesign(.rounded)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("No worries! It happens!Please provide your\nemail address for Bandmates to send you a password reset link")
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                        .lineSpacing(-3)
                }.frame(maxWidth: .infinity)
                VStack(spacing:50) {
                    InputField(label: "", placeholder: "Enter email", text: $fVM.email)
                        .padding(.horizontal,30)
                    buttonView(action: {
                        fVM.sendResetLink()
                    }, buttonText: "Send", height: 55)
                        .padding(.horizontal,28)
                        .overlay {
                            if fVM.isLoading {
                                ProgressView().tint(.green)
                            }
                        }
                    if let error = fVM.errorMessage {
                        Text(error)
                            .font(.dmSans(14, weight: .semiBold))
                            .foregroundStyle(.red)
                    }
                    if let sucess = fVM.successMessage {
                        Text(sucess)
                            .font(.dmSans(14, weight: .semiBold))
                            .foregroundStyle(.green)
                    }
                }
                Spacer()
            }
            if fVM.isEmailSent {
                passwordResetConfirmationView( showsucessSheet: $fVM.isEmailSent)
                    .transition(.scale.animation(.easeInOut(duration: 0.5)))
            }
        }
    }
}
#Preview {
    forgetPaswordView()
}
