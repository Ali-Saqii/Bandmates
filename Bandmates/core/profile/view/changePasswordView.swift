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
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack(spacing:20) {
                Divider()
                SecureInputField(label: "Password", placeholder: "Enter Password", text: $oldPassword)
                SecureInputField(label: "New Password", placeholder: "Enter New Password", text: $newPassword)
                SecureInputField(label: "Confirm Password", placeholder: "......", text: $ConfirmNewPassword)
                buttonView(action: {}, buttonText: "Change Password", height: 50)
                    .padding(.top)
                Spacer()
            }.padding(.horizontal,30)
        }.navigationTitle("Change Password")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    changePasswordView()
        .environmentObject(ProfileViewModel())
}
