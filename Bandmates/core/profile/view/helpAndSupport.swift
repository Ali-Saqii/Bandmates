//
//  helpAndSupport.swift
//  Bandmates
//
//  Created by Mac mini on 23/03/2026.
//

import SwiftUI

struct helpAndSupport: View {
    @State private var name = ""
    @State private var contactNumber = ""
    @State private var email = ""
    @State private var feddBackText = ""
    @State private var feedBackPlaceHolde = "Your feedback is important to us..."
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack(spacing:20) {
            
                TextField("Enter Name", text: $name)
                    .keyboardType(.default)
                    .autocapitalization(.words)
                    .font(.system(size: 15))
                    .padding(.horizontal, 16)
                    .frame(height: 50)
                    .background(Color.textfieldcolor.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.inputBorder, lineWidth: 1)
                    )
                TextField("Your Contact Number", text: $contactNumber)
                    .keyboardType(.decimalPad)
                    .autocapitalization(.none)
                    .font(.system(size: 15))
                    .padding(.horizontal, 16)
                    .frame(height: 50)
                    .background(Color.textfieldcolor.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.inputBorder, lineWidth: 1)
                    )
                TextField("Your email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .font(.system(size: 15))
                    .padding(.horizontal, 16)
                    .frame(height: 50)
                    .background(Color.textfieldcolor.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.inputBorder, lineWidth: 1)
                    )

                TextEditor(text: $feddBackText)
                    .padding(.horizontal)
                    .frame(height: 200)
                    .scrollContentBackground(.hidden)
                       .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.textfieldcolor.opacity(0.3))
                       )
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(lineWidth: 1)
                            .stroke(Color.inputBorder, lineWidth: 1)
                            .overlay(alignment:.topLeading) {
                                Text(feedBackPlaceHolde)
                                    .font(.callout)
                                    .foregroundStyle(.gray.opacity(0.7))
                                    .padding()
                            }.onTapGesture {
                                feedBackPlaceHolde = ""
                            }
                    })
                   
                buttonView(action: {}, buttonText: "Send", height: 50)
                    .padding(.vertical)
                Divider()
                
                Text("We Are Available On")
                    .font(.dmSans(16, weight: .semiBold))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
             
                    HStack {
                        Image(systemName: "globe")
                            .font(.title)
                            .foregroundStyle(.green)
                        Text("bandmatesweb.com")
                            .font(.dmSans(14, weight: .medium))
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture {
                        print("website")
                    }
                    HStack {
                        Image("gmail")
                            .font(.title)
                            .foregroundStyle(.green)
                        Text("bandmatesofficial@gmail.com")
                            .font(.dmSans(14, weight: .medium))
                            .foregroundStyle(.black)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture {
                        print("email")

                    }
                    .offset(x:5)
                Spacer()
            }.padding(.horizontal,30)
                .padding(.top)
                .overlay(alignment:.top,content: {
                    Divider()
                })
                .navigationTitle("Help & Support")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    helpAndSupport()
}
