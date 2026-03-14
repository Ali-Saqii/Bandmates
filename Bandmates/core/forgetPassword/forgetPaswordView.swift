//
//  forgetPaswordView.swift
//  Bandmates
//
//  Created by Mac mini on 14/03/2026.
//

import SwiftUI

struct forgetPaswordView: View {
    @State private var textFieldText = ""
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
                    InputField(label: "", placeholder: "Enter email", text: $textFieldText)
                        .padding(.horizontal,30)
                    buttonView(action: {}, buttonText: "Send", height: 55)
                        .padding(.horizontal,28)
                }
                Spacer()
            }
           
        }
    }
}
#Preview {
    forgetPaswordView()
}
