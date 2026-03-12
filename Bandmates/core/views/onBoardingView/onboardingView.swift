//
//  onboardingView.swift
//  Bandmates
//
//  Created by Mac mini on 13/03/2026.
//

import SwiftUI
struct OnboardingPage: Identifiable {
    let id = UUID()
    let illustration: String
    let title: String
    let subtitle: String
}

struct onboardingView: View {
    @State private var showLogin = false
    @State private var currentPage = 0

    let pages: [OnboardingPage] = [
        OnboardingPage(
            illustration: "page1logo",
            title: "Explore & Rate Albums",
            subtitle: "Dive into music like never before. Rate albums, share your thoughts, and see how your friends feel about the same tracks."
        ),
        OnboardingPage(
            illustration: "page2logo",
            title: "Connect with Bandmates",
            subtitle: "Send requests and discover users with similar taste. Build your circle — one album at a time."
        ),
        OnboardingPage(
            illustration: "page3logo",
            title: "Curate Your Collections",
            subtitle: "Save your favorite albums and keep them organized. Your personal library grows with every great find."
        )
    ]

    var body: some View {
        if showLogin {
            LoginView(showLogin: $showLogin)
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing),
                    removal: .move(edge: .leading)
                ))
        } else {
            OnboardingContainerView(
                pages: pages,
                currentPage: $currentPage,
                showLogin: $showLogin
            )
            .transition(.asymmetric(
                insertion: .move(edge: .leading),
                removal: .move(edge: .trailing)
            ))
        }
    }
}


// MARK: - Login View
struct LoginView: View {
    @Binding var showLogin: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = false
    @State private var showPassword = false
    @State private var appeared = false

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {

                    // Logo
                    HStack {
                        Spacer()
                        Spacer()
                    }
                    .padding(.top, 60)
                    .padding(.bottom, 28)

                    // Welcome text
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Welcome back!")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(.textPrimary)

                        Text("Login to continue!")
                            .font(.system(size: 15))
                            .foregroundColor(.textSecondary)
                    }
                    .padding(.horizontal, 28)
                    .padding(.bottom, 32)
                    .offset(y: appeared ? 0 : 20)
                    .opacity(appeared ? 1 : 0)
                    .animation(.easeOut(duration: 0.5).delay(0.1), value: appeared)

                    // Email field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.textPrimary)

                        TextField("Enter email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .font(.system(size: 15))
                            .padding(.horizontal, 16)
                            .frame(height: 50)
                            .background(Color.white)
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

                    // Password field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.system(size: 13, weight: .medium))
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
                        .background(Color.white)
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

                    // Remember me + Forgot password
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

                        Button {
                            // Forgot password
                        } label: {
                            Text("Forgot password?")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.brandPink)
                        }
                    }
                    .padding(.horizontal, 28)
                    .padding(.bottom, 28)
                    .offset(y: appeared ? 0 : 20)
                    .opacity(appeared ? 1 : 0)
                    .animation(.easeOut(duration: 0.5).delay(0.25), value: appeared)

                    // Login button
                    Button {
                        // Login action
                    } label: {
                        Text("Login")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(Color.brandPink)
                            .clipShape(Capsule())
                    }
                    .padding(.horizontal, 28)
                    .padding(.bottom, 24)
                    .offset(y: appeared ? 0 : 20)
                    .opacity(appeared ? 1 : 0)
                    .animation(.easeOut(duration: 0.5).delay(0.3), value: appeared)

                    // Divider
                    HStack {
                        Rectangle()
                            .fill(Color.inputBorder)
                            .frame(height: 1)
                        Text("or continue with")
                            .font(.system(size: 13))
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

                    // Social login
                    HStack(spacing: 16) {
                        SocialLoginButton(icon: "g.circle.fill", label: "Google", iconColor: .red)
                        SocialLoginButton(icon: "apple.logo", label: "Apple", iconColor: .black)
                    }
                    .padding(.horizontal, 28)
                    .padding(.bottom, 32)
                    .opacity(appeared ? 1 : 0)
                    .animation(.easeOut(duration: 0.5).delay(0.4), value: appeared)

                    // Sign up
                    HStack(spacing: 4) {
                        Spacer()
                        Text("Don't have an account?")
                            .font(.system(size: 14))
                            .foregroundColor(.textSecondary)
                        Button {
                            withAnimation(.spring()) {
                                showLogin = false
                            }
                        } label: {
                            Text("Sign Up")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.brandPink)
                        }
                        Spacer()
                    }
                    .padding(.bottom, 40)
                    .opacity(appeared ? 1 : 0)
                    .animation(.easeOut(duration: 0.5).delay(0.45), value: appeared)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                appeared = true
            }
        }
    }
}

// MARK: - Social Login Button
struct SocialLoginButton: View {
    let icon: String
    let label: String
    let iconColor: Color

    var body: some View {
        Button {
            // Social login action
        } label: {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(iconColor)
                Text(label)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.textPrimary)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.inputBorder, lineWidth: 1.5)
            )
        }
    }
}

// MARK: - Preview
#Preview {
    onboardingView()
}
