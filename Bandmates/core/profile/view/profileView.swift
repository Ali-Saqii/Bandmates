//
//  profileView.swift
//  Bandmates
//
//  Created by Mac mini on 18/03/2026.
//

import SwiftUI
import Foundation

struct buttonModel {
    let image: String
    let name: String
    let Color: Color
    let action: () -> Void
}
struct profileView: View {
    @StateObject var profileVm = ProfileViewModel()
    @EnvironmentObject var aVm: AuthViewModel
    @State private var editProfileView = false
    @State private var showHelpAndSupport = false
    @State private var logoutAccount = false
    @State private var showBillingPlans = false
    @State private var accountSetting = false
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea(.all)
            VStack(spacing:20) {
                if let user = profileVm.user {
                    
                    if user.subscriptionPlan == "club" || user.isOnTrial {
                        headerButtonView
                            .onTapGesture {
                                showBillingPlans = true
                            }
                    }
                }
                profieGridView
                buttonsListView
              
                Spacer()
            }.padding(.horizontal)
            
        }.fullScreenCover(isPresented: $logoutAccount, content: {
            ZStack {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .onTapGesture {
                        logoutAccount = false
                    }
                reUsableBottomSheet(
                    sheetTitle: "Logout Account?",
                    sheetWarning: "Are you sure you want to logout your Account?",
                    buttonTitle1: "cancel",
                    buttonTitle2: "Yes,Logout",
                    button1Action: {
                       
                        logoutAccount = false
                    },
                    button2Action: {
                        aVm.signOut()
                        logoutAccount = false
                    },
                    button1Role: .cancel,
                    button2Role: .destructive,
                )
            }
            .background(ClearBackgroundView())
            
        })
        .environmentObject(profileVm)
        .navigationDestination(isPresented: $editProfileView) {
            EditProfileView(user: profileVm.user ?? userModel(id: "", profileImage: "", fullName: "", userName: "", Bio: "", waiting: 0, totalBandmates: 0, toralSavedAlbums: 0, email: "",subscriptionPlan: "Club",isOnTrial: false))
                .environmentObject(profileVm)
        }
        .navigationDestination(isPresented: $showHelpAndSupport) {
            helpAndSupport()
                .environmentObject(profileVm)
        }
        .navigationDestination(isPresented: $showBillingPlans) {
            chooseSubscriptionView()
                .environmentObject(profileVm)
                .environmentObject(aVm)
        }
        .navigationDestination(isPresented: $accountSetting) {
            AccountSetingView()
                .environmentObject(profileVm)
        }
    }

  
}
extension profileView {
    // MARK : headerButtonView

    private var headerButtonView: some View {
        HStack {
            Image("CrownIcon")
                .padding(.leading)
            VStack(alignment: .leading, spacing: nil) {
                Text("Upgrade Plan Now")
                    .font(.dmSans(18, weight: .semiBold))
                    .foregroundStyle(.white)
                Text("Unlock exclusive features & connect deeper with your music world! ")
                    .font(.dmSans(10, weight: .medium))
                    .foregroundStyle(.white)
                    .padding(.trailing)
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 80)
            .background(Color.background)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    // MARK : profile View
    private var profieGridView: some View {
        VStack {
            if let user  = profileVm.user {
                HStack{
                    
                    AsyncImage(url: URL(string: user.profileImage.hasPrefix("http")
                                        ? user.profileImage
                                        : "http://localhost:3000/\(user.profileImage)")) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                        } else if phase.error != nil {
                            Text(user.fullName.initials ?? "")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(width: 46, height: 46)
                                .background(
                                    Circle()
                                        .fill(.secondary.opacity(0.6))
                                )
                        } else if user.profileImage.isEmpty {
                            Text(user.fullName.initials  ?? "")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(width: 46, height: 46)
                                .background(
                                    Circle()
                                        .fill(.secondary.opacity(0.6))
                                )
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(width: 46, height: 46)
                    .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        
                        Text(user.fullName)
                            .font(.dmSans(15, weight: .semiBold))
                            .foregroundStyle(.black)
                        Text(user.userName)
                            .font(.dmSans(12, weight: .medium))
                            .foregroundStyle(.gray)
                        
                    }
                    Spacer()
                    Image(systemName: "pencil.line")
                        .font(.caption)
                        .foregroundStyle(.white)
                        .frame(width: 25, height: 25)
                        .background(
                            Circle()
                                .fill(Color.background)
                        ).onTapGesture {
                            withAnimation() {
                                editProfileView = true
                            }
                        }
                }.padding(.horizontal)
                    .padding(.top)
                    .onAppear {
                        print("🖼️ Image URL: http://localhost:3000/\(user.profileImage)")
                    }
                VStack(alignment:.leading) {
                    Text("Bio")
                        .font(.dmSans(14, weight: .bold))
                        .foregroundStyle(.black)
                    Text(user.Bio)
                        .font(.dmSans(12, weight: .regular))
                        .foregroundStyle(.gray)
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Divider()
                HStack {
                    VStack{
                        Text("\(user.waiting)")
                            .font(.dmSans(15, weight: .semiBold))
                            .foregroundStyle(.black)
                        Text("Waiting\nto Jam")
                            .multilineTextAlignment(.center)
                            .font(.dmSans(12, weight: .medium))
                            .foregroundStyle(.gray)
                    }.frame(maxWidth: .infinity)
                        .frame(height:55)
                    Divider()
                    VStack{
                        Text("\(user.totalBandmates)")
                            .font(.dmSans(15, weight: .semiBold))
                            .foregroundStyle(.black)
                        
                        Text("Total\nBandmates")
                            .multilineTextAlignment(.center)
                            .font(.dmSans(12, weight: .medium))
                            .foregroundStyle(.gray)
                    }.frame(maxWidth: .infinity)
                        .frame(height:55)
                    Divider()
                    VStack{
                        Text("\(user.toralSavedAlbums)")
                            .font(.dmSans(15, weight: .semiBold))
                            .foregroundStyle(.black)
                        Text("Albums\nSaved")
                            .multilineTextAlignment(.center)
                            .font(.dmSans(12, weight: .medium))
                            .foregroundStyle(.gray)
                            .lineLimit(2)
                    }.frame(maxWidth: .infinity)
                        .frame(height:55)
                    
                }.padding(.bottom)
            }
            }.frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 200)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: .gray.opacity(0.3), radius: 8)
    
    }
    // MARK : buttonsListView

    private var buttonsListView: some View {
     
            VStack(spacing: 20) {
                ButtonsRowView(icon: "star", title: "Billing & Subscription", text: "", color: .black, action: {
                    showBillingPlans = true
                })
                Divider()
                ButtonsRowView(icon: "check", title: "Account Settings", text: "", color: .black, action: {
                    accountSetting = true
                })
                Divider()
                ButtonsRowView(icon: "headphones", title: "help & support", text: "", color: .black, action: {
                    showHelpAndSupport = true
                })
                Divider()
                ButtonsRowView(icon: "Logout", title: "logout Account", text: "", color: .black, action: {
                    logoutAccount = true
                })
            
            }.frame(maxWidth: .infinity, alignment: .leading)
            .padding([.top,.bottom],20)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: .gray.opacity(0.3), radius: 8)
   
            
    }
}
#Preview {
    profileView()
        .environmentObject(ProfileViewModel())
        .environmentObject(AuthViewModel())
}

