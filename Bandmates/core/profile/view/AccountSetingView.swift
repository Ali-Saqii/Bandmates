//
//  AccountSetingView.swift
//  Bandmates
//
//  Created by Mac mini on 29/03/2026.
//

import SwiftUI

struct AccountSetingView: View {
    @EnvironmentObject var pVm: ProfileViewModel
    @State private var NotificationSettings = false
    @State private var CollectionVisibility = false
    @State private var ChangePassword = false
    @State private var TermsofServices = false
    @State private var PrivacyPolicy = false
    @State private var DeleteAccount = false
    @State private var text = ""
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack(spacing:30) {
                Divider()
                ButtonsRowView(icon: "bell", title: "Notification Settings", text: "", color: .black, action: {
                    NotificationSettings.toggle()
                })
                ButtonsRowView(icon: "eye", title: "Collection Visibility", text: text, color: .black, action: {
                    withAnimation {
                        CollectionVisibility.toggle()
                    }
                })
                ButtonsRowView(icon: "lock", title: "Change Password", text: "", color: .black, action: {
                    ChangePassword.toggle()
                })
                ButtonsRowView(icon: "list", title: "Terms of Services", text: "", color: .black, action: {
                    TermsofServices.toggle()
                })
                ButtonsRowView(icon: "privacy", title: "Privacy Policy", text: "", color: .black, action: {
                    PrivacyPolicy.toggle()
                })
                ButtonsRowView(icon: "bin", title: "Delete", text: "", color: .red, action: {
                    withAnimation() {
                        DeleteAccount = true
                    }
                })
                Spacer()
            }
            if DeleteAccount {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation() {
                            DeleteAccount = false
                        }
                    }
                bottomsheetAccountSetting(
                    sheetTitle: "Delete Account?",
                    sheetWarning: "Are you sure you want to delete your Account?",
                    buttonTitle1: "Cancel",
                    buttonTitle2: "Yes, Delete",
                    button1Action: {
                        withAnimation() {
                            DeleteAccount = false
                        }
                    },
                    button2Action: {
                        withAnimation() {
                            pVm.deleteAccount()
                            DeleteAccount = false
                        }
                    },
                    button1Role: nil,
                    button2Role: nil
                ).transition(.asymmetric(insertion:.move(edge: .bottom), removal: .move(edge: .bottom)))
                    .overlay {
                        if pVm.isLoading {
                            ProgressView()
                        }
                    }
            }
            if CollectionVisibility {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation() {
                            CollectionVisibility = false
                        }
                    }
                collectionVisiBilityView(showSheet: $CollectionVisibility
                ).transition(.asymmetric(insertion:.move(edge: .bottom), removal: .move(edge: .bottom)))
            }
        }.navigationTitle("Account Setting")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $TermsofServices) {
                termsOfServicesView()
            }
            .navigationDestination(isPresented: $PrivacyPolicy) {
                privacyPolicyView()
            }
            .navigationDestination(isPresented: $ChangePassword) {
                changePasswordView()
                    .environmentObject(pVm)
            }
            .navigationDestination(isPresented: $NotificationSettings) {
                NotificationSettinfView()
                    .environmentObject(pVm)
            }
            .navigationDestination(isPresented: $pVm.isDeleted) {
                onboardingView()
            }
        
    }
}
#Preview {
    AccountSetingView()
        .environmentObject(ProfileViewModel())
}
