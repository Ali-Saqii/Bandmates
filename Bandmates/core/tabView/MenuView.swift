//
//  MenuView.swift
//  Bandmates
//
//  Created by Mac mini on 22/03/2026.
//

import SwiftUI

struct MenuView: View {
    @StateObject var vm: HomeViewModel = HomeViewModel()
    var initialise: String? {
        let formatter = PersonNameComponentsFormatter()
        guard let components = formatter.personNameComponents(from: vm.user.fullName) else {
            return nil
            
        }
        formatter.style = .abbreviated
        return formatter.string(from: components)
    }
    @Binding var showMenu: Bool
//    @Binding var selectedTab: AppTab
    let homeButtonAction: () -> Void
    let ratingButtonAction: () -> Void
    let shareButtonAction: () -> Void
    let logoutButtonAction: () -> Void
  
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                AsyncImage(url: URL(string: vm.user.profileImage)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else if phase.error != nil {
                        Text(initialise ?? "")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 60, height: 60)
                            .background(
                                Circle()
                                    .fill(.secondary.opacity(0.6))
                            )
                    } else if vm.user.profileImage.isEmpty {
                        Text(initialise ?? "")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 60, height: 60)
                            .background(
                                Circle()
                                    .fill(.secondary.opacity(0.6))
                            )
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding(.leading)
                VStack(alignment: .leading,spacing: 10) {
                    Text(vm.user.fullName)
                        .font(.system(size: 18, weight: .semibold))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .lineLimit(1)
                    Text(vm.user.email)
                        .font(.system(size: 13, weight: .medium))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .lineLimit(1)
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: UIScreen.main.bounds.height * 0.3)
                .background(Color.background)
            VStack(alignment: .leading, spacing: 25) {
                    HStack {
                        Image("home")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("Home")
                            .font(.system(size: 18, weight: .semibold))

                    }.frame(maxWidth: .infinity,alignment: .leading)
                    .onTapGesture {
                       homeButtonAction()
                        showMenu = false
                    }
                NavigationLink {
                    Bandmates()
                } label: {
                    HStack {
                        Image("bandmates")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("Bandmates")
                            .foregroundStyle(.black)
                            .font(.system(size: 18, weight: .semibold))

                    }.frame(maxWidth: .infinity,alignment: .leading)
                    
                }

                HStack {
                    Image("ratings")
                        .resizable()
                        .frame(width: 25, height: 25)
                    Text("Rate on Playstore")
                        .font(.system(size: 18, weight: .semibold))

                }.frame(maxWidth: .infinity,alignment: .leading)
                    .onTapGesture {
                        print("rateonplaystore")
                        ratingButtonAction()
                        showMenu = false

                    }
                HStack {
                    Image("share")
                        .resizable()
                        .frame(width: 25, height: 25)
                    Text("Share App")
                        .font(.system(size: 18, weight: .semibold))

                }.frame(maxWidth: .infinity,alignment: .leading)
                    .onTapGesture {
                        print("share app")
                        shareButtonAction()
                        showMenu = false

                    }
                NavigationLink {
                    helpAndSupport()
                } label: {
                    
                    HStack {
                        Image("contact")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("Help & Support")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.black)

                    }.frame(maxWidth: .infinity,alignment: .leading)
                }
                Divider()
                HStack {
                    Image("logout")
                        .resizable()
                        .frame(width: 25, height: 25)
                    Text("Logout")
                        .font(.system(size: 18, weight: .semibold))

                }.frame(maxWidth: .infinity,alignment: .leading)
                    .onTapGesture {
                        print("logout")
                        logoutButtonAction()
                        showMenu = false

                    }
                Spacer()
            }.frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: UIScreen.main.bounds.height * 0.7)
                .padding(.top,30)
                .padding(.horizontal)
            
        }.background(
            Color.white
                .ignoresSafeArea(edges: .all)
        )
        .frame(maxHeight: .infinity)
        .frame(width: UIScreen.main.bounds.width * 0.8)
    }
}

#Preview {
    MenuView(showMenu: .constant(true),
             homeButtonAction: {},
             ratingButtonAction: {},
             shareButtonAction: {},
             logoutButtonAction: {}
    )
}
