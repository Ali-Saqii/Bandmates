//
//  LoginView.swift
//  Bandmates
//
//  Created by Mac mini on 13/03/2026.
//

import SwiftUI

struct LoginView: View {
    @Binding var showLogin: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = false
    @State private var showPassword = false
    @State private var appeared = false
    @State private var forgetPassword = false
    @Binding var showSignUP : Bool
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        headerView
                        emailView
                        passwordView
                        middleButtonsView
                        buttonView(action: {}, buttonText: "Login", height: 55)
                            .padding(.horizontal, 28)
                            .padding(.bottom, 24)
                            .offset(y: appeared ? 0 : 20)
                            .opacity(appeared ? 1 : 0)
                            .animation(.easeOut(duration: 0.5).delay(0.3), value: appeared)
                        dividerView
                        socialButtonsViews
                        Spacer()
                        signUpView
                    }
                }
                .navigationDestination(isPresented: $forgetPassword) {
                    forgetPaswordView()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    appeared = true
                    print("ligin Screen: showlogin \(showLogin) and showSignUp \(showSignUP)")
                }
            }
        }
    }
}
extension LoginView {
    private var headerView: some View {
        VStack {
            HStack {
                Spacer()
                Text("Bandmates")
                    .foregroundColor(.background)
                    .font(.largeTitle)
                    .fontDesign(.serif)
                    .bold()
                Spacer()
            }
            .padding(.top, 60)
            .padding(.bottom, 10)
            
            HStack {
                Spacer()
                VStack(alignment: .center, spacing: 6) {
                    Text("Welcome back!")
                        .font(.system(size: 24, weight:.semibold))
                        .foregroundColor(.textPrimary)
                    
                    Text("Login to continue!")
                        .font(.system(size: 18))
                        .foregroundColor(.textSecondary)
                }
                Spacer()
            }
        }.offset(y: appeared ? 0 : 20)
            .opacity(appeared ? 1 : 0)
            .animation(.easeOut(duration: 0.5).delay(0.1), value: appeared)
    }
    private var emailView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Email")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.textPrimary)

            TextField("Enter email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .font(.system(size: 15))
                .padding(.horizontal, 16)
                .frame(height: 50)
                .background(Color.textfieldcolor.opacity(0.3))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(email.isEmpty ? Color.inputBorder : Color.brandPink, lineWidth: 1)
                )
        }
        .padding(.horizontal, 28)
        .padding(.bottom, 18)
        .offset(y: appeared ? 0 : 20)
        .opacity(appeared ? 1 : 0)
        .animation(.easeOut(duration: 0.5).delay(0.15), value: appeared)

    }
    private var passwordView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Password")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.textPrimary)

            HStack {
                Group {
                    if showPassword {
                        TextField("Enter password", text: $password)
                    } else {
                        SecureField("Enter password", text: $password)
                    }
                }
                .font(.system(size: 15))

                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(.textSecondary)
                        .font(.system(size: 16))
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 50)
            .background(Color.textfieldcolor.opacity(0.3))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(password.isEmpty ? Color.inputBorder : Color.brandPink, lineWidth: 1)
            )
        }
        .padding(.horizontal, 28)
        .padding(.bottom, 16)
        .offset(y: appeared ? 0 : 20)
        .opacity(appeared ? 1 : 0)
        .animation(.easeOut(duration: 0.5).delay(0.2), value: appeared)

    }
    private var middleButtonsView: some View {
        HStack {
            Button {
                rememberMe.toggle()
            } label: {
                HStack(spacing: 8) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(rememberMe ? Color.brandPink : Color.white)
                            .frame(width: 18, height: 18)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(rememberMe ? Color.brandPink : Color.inputBorder, lineWidth: 1.5)
                            )
                        if rememberMe {
                            Image(systemName: "checkmark")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    Text("Remember me")
                        .font(.system(size: 13))
                        .foregroundColor(.textPrimary)
                }
            }

            Spacer()
            textButton(action: {
                forgetPassword = true
            }, text: "forget Password?".capitalized, color: .background, textSize: 13)
        }
        .padding(.horizontal, 28)
        .padding(.bottom, 28)
        .offset(y: appeared ? 0 : 20)
        .opacity(appeared ? 1 : 0)
        .animation(.easeOut(duration: 0.5).delay(0.25), value: appeared)
    }
    private var dividerView: some View {
        
        HStack {
            Rectangle()
                .fill(Color.inputBorder)
                .frame(height: 1)
            Text("or continue with")
                .font(.system(size: 14))
                .foregroundColor(.textSecondary)
                .fixedSize()
            Rectangle()
                .fill(Color.inputBorder)
                .frame(height: 1)
        }
        .padding(.horizontal, 28)
        .padding(.bottom, 24)
        .opacity(appeared ? 1 : 0)
        .animation(.easeOut(duration: 0.5).delay(0.35), value: appeared)

    }
    private var socialButtonsViews: some View {
        HStack(spacing: 25) {
            SocialLoginButton(icon: "g.circle.fill", label: "Google", iconColor: .red)
            SocialLoginButton(icon: "apple.logo", label: "Apple", iconColor: .black)
        }
        .padding(.horizontal, 28)
        .padding(.bottom, 32)
        .opacity(appeared ? 1 : 0)
        .animation(.easeOut(duration: 0.5).delay(0.4), value: appeared)
    }
    private var signUpView: some View {
        HStack(spacing: 4) {
            Spacer()
            Text("Don't have an account?")
                .font(.system(size: 16))
                .foregroundColor(.textSecondary)
            Button {
                    showLogin = false
                    showSignUP = true
            } label: {
                Text("Sign Up")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.background)
            }
            Spacer()
        }
        .opacity(appeared ? 1 : 0)
        .animation(.easeOut(duration: 0.5).delay(0.45), value: appeared)
    }
}
#Preview {
    LoginView(showLogin: .constant(true), showSignUP: .constant(false))
}
