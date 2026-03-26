//
//  SignUp.swift
//  Bandmates
//
//  Created by Mac mini on 13/03/2026.
//

import SwiftUI

struct SignUp: View {
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var agreedToTerms: Bool = true
    @State private var showPassword: Bool = false
    @State private var showConfirmPassword: Bool = false
    @State private var profileImage: UIImage? = nil
    @State private var showImagePicker: Bool = false
    @Binding var showSignUp : Bool
    @Binding var showLogin : Bool
    @State private var appeared = false
    @State private var showTabView = false
    var body: some View {
            ZStack {
                Color.white
                    .ignoresSafeArea(.all)
                ScrollView {
                    VStack(spacing: 10) {
                        headerTextView
                        headerImagePickerView
                        textFieldsView
                        VStack(spacing:40) {
                            termsAndConditionView
                            buttonView(action: {
                                showTabView.toggle()
                            }, buttonText: "Sign Up", height: 55)
                                .padding(.horizontal)
                                .offset(y: appeared ? 0 : 20)
                            footerSignInButton
                        }
                    }
                }.scrollIndicators(.hidden)
                    .scrollTargetBehavior(.viewAligned)
                    .scrollBounceBehavior(.basedOnSize)
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(image: $profileImage)
                    }
            }.navigationDestination(isPresented: $showTabView, destination: {
                tabView()
            })
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    withAnimation(.spring) {
                        appeared = true
               
                    }
                }
            }
        }
    }
extension SignUp {
    private var headerTextView: some View {
        VStack(spacing: 4) {
            Text("Create Account!")
                .font(.system(size: 26, weight: .semibold))
                .foregroundColor(.black)
                .offset(y: appeared ? 0 : 20)
            Text("Signup to get started!")
                .font(.system(size: 22))
                .foregroundColor(.gray)
                .offset(y: appeared ? 0 : 20)
        }
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
    private var headerImagePickerView: some View {
        VStack(spacing: 7) {
            ZStack(alignment: .bottomTrailing) {
                Circle()
                    .strokeBorder(
                        Color.background,
                        lineWidth: 2
                    )
                    .frame(width: 100, height: 100)
                    .overlay(
                        Group {
                            if let image = profileImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color.background)
                                    .background(
                                        Circle()
                                            .fill(.background.opacity(0.2))
                                            .frame(width: 80,height: 80)
                                    )
                                
                            }
                        }.offset(y: appeared ? 0 : 20)
                    )
                Button(action: { showImagePicker = true }) {
                    ZStack {
                        Circle()
                            .fill(Color.background)
                            .frame(width: 23, height: 23)
                        Image(systemName: "plus")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .offset(x: 0, y: -3)
            }
            
            Text("Add Profile Image")
                .font(.default)
                .foregroundColor(.black)
            
        }
    }
    private var textFieldsView: some View {
        VStack(spacing: 16) {
            InputField(
                label: "Full Name",
                placeholder: "Enter name",
                text: $fullName
            )
            .offset(y: appeared ? 0 : 20)
            InputField(
                label: "Email",
                placeholder: "Enter email",
                text: $email,
                keyboardType: .emailAddress
            )
            .offset(y: appeared ? 0 : 20)
            HStack(alignment: .center) {
                Group {
                    if showPassword {
                        InputField(label: "Password", placeholder:"Enter Password" , text: $password, keyboardType: .default)
                            .offset(y: appeared ? 0 : 20)
                    } else {
                        SecureInputField(
                            label: "Password",
                            placeholder: "Enter password",
                            text: $password,
                        )
                        .offset(y: appeared ? 0 : 20)
                    }
                }
                .overlay(alignment: .trailing) {
                    textFieldButtonsView(isVisible: $showPassword)
                        .offset(x: -10,y:20)
                }
            }
            
            Group {
                if showConfirmPassword {
                    InputField(label: "Confirm Password", placeholder: "············", text: $confirmPassword, keyboardType: .default)
                        .offset(y: appeared ? 0 : 20)
                } else {
                    SecureInputField(
                        label: "Confirm Password",
                        placeholder: "············",
                        text: $confirmPassword,
                    )
                    .offset(y: appeared ? 0 : 20)
                }
            }.overlay(alignment: .trailing) {
                textFieldButtonsView(isVisible: $showConfirmPassword)
                    .offset(x: -10,y:10)
            }
        }
        .padding(.horizontal, 24)
    }
    private var termsAndConditionView: some View {
        HStack(spacing: 8) {
            Button(action: { agreedToTerms.toggle() }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(agreedToTerms ? Color.background : Color.white)
                        .frame(width: 18, height: 18)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(agreedToTerms ? Color.clear : Color.gray.opacity(0.4), lineWidth: 1.5)
                        )
                    if agreedToTerms {
                        Image(systemName: "checkmark")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }
            
            HStack(spacing: 4) {
                Text("I agree to the")
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                textButton(action: {}, text: "terms and condition", color: .background, textSize: 15)
                    .underline()
            }.offset(y: appeared ? 0 : 20)
            
            Spacer()
        }
        .padding(.horizontal, 24)
    }
    private var footerSignInButton: some View {
        HStack(spacing: 4) {
            Text("Already have an account?")
                .font(.headline)
                .foregroundColor(.gray)
            textButton(action: {
                showLogin = true
                showSignUp = false
            }, text: "Login", color: .background, textSize: 18)
        }.offset(y: appeared ? 0 : 20)
    }
}
#Preview {
    SignUp(showSignUp: .constant(true), showLogin: .constant(false))
}
