//
//  changePasswordView.swift
//  Bandmates
//
//  Created by Mac mini on 29/03/2026.
//

import SwiftUI

struct changePasswordView: View {
    @EnvironmentObject var pvm : ProfileViewModel
    @State private var oldPassword = ""
    @State private var newPassword = ""
    @State private var ConfirmNewPassword = ""
    @State var showOldPassword = false
    @State var showNewPassword = false
    @State var showConfirmNewPassword = false
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack(spacing:20) {
                Divider()
                Group {
                   
                    if showOldPassword {
                        InputField(label: "Password", placeholder: "Enter Password", text: $oldPassword)
                    } else {
                        SecureInputField(label: "Password", placeholder: "Enter Password", text: $oldPassword)
                    }
                }.overlay(alignment: .trailing) {
                    textFieldButtonsView(isVisible: $showOldPassword)
                        .offset(x: -10,y:10)
                }
                Group {
                   
                    if showNewPassword {
                        InputField(label: "New Password", placeholder: "Enter New Password", text: $newPassword)
                    } else {
                        SecureInputField(label: "New Password", placeholder: "Enter New Password", text: $newPassword)
                    }
                }.overlay(alignment: .trailing) {
                    textFieldButtonsView(isVisible: $showNewPassword)
                        .offset(x: -10,y:10)
                }
                Group {
            
                    if showConfirmNewPassword {
                        InputField(label: "Confirm Password", placeholder: "......", text: $ConfirmNewPassword)
                    } else {
                        SecureInputField(label: "Confirm Password", placeholder: "......", text: $ConfirmNewPassword)
                    }
                }.overlay(alignment: .trailing) {
                    textFieldButtonsView(isVisible: $showConfirmNewPassword)
                        .offset(x: -10,y:10)
                }
                buttonView(action: {
                    changePassword()
                    if pvm.passwordSuccess {
                        dismiss()
                    }
                }, buttonText: "Change Password", height: 50)
                    .padding(.top)
                Spacer()
                if !pvm.passwordSuccess {
                    if let message = pvm.passwordError {
                        Text(message).foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                    }
                }
                Spacer()
            }.padding(.horizontal,30)
        }.overlay(content: {
            if pvm .isLoading {
                Rectangle()
                    .fill(Color.textfieldcolor.opacity(0.5))
                    .ignoresSafeArea()
                    .overlay {
                        ProgressView()
                            .tint(Color.background)
                    }
            }
        })
        .navigationTitle("Change Password")
            .navigationBarTitleDisplayMode(.inline)
    }
    private func changePassword() {
        pvm.updatePassword(oldPassword: oldPassword, newPassword: newPassword, confirmPassword: ConfirmNewPassword)
    }
}

#Preview {
    changePasswordView()
        .environmentObject(ProfileViewModel())
}
