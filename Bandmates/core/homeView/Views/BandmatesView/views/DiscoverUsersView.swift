//
//  DiscoverUsersView.swift
//  Bandmates
//
//  Created by Mac mini on 23/03/2026.
//

import SwiftUI

struct DiscoverUsersView: View {
    @EnvironmentObject var Bvm : BandMatesViewModel
    @State private var selectedPerson: BandmateModel? = nil
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            if Bvm.users != nil && Bvm.users != [] {
                ScrollView {
                    VStack {
                        if let users = Bvm.users {
                            ForEach(users) { user in
                                OrtherUsersRowView(
                                    personImage: user.image,
                                    PersonName: user.fullName,
                                    personUserName: user.userName,
                                    isRequested: user.isRequested,
                                    buttonAction: {
                                        
                                    }
                                ).onTapGesture {
                                    selectedPerson = user
                                }
                            }
                        } else{}
                    }
                }.refreshable {
                    Bvm.refresh()
                }
                .scrollIndicators(.hidden)
                    .scrollBounceBehavior(.basedOnSize)
            } else {
                NoBandmatesView(icon: "network.slash",height: 70,width: 80, title: "No internet!", subTitle: "Check your internet and try again later!!!", titleFont: .dmSans(20, weight: .semiBold), subTitleFont: .dmSans(14, weight: .semiBold), color: Color.background.opacity(0.5))
            }
        }
        .navigationDestination(item: $selectedPerson, destination: { person in
            orthersProfile(bandmate: person)
                .environmentObject(Bvm)
        })
        }
    }


#Preview {
    DiscoverUsersView()
        .environmentObject(BandMatesViewModel())
}
