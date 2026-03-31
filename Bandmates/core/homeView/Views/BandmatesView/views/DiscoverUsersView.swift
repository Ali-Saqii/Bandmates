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
            }.scrollIndicators(.hidden)
                .scrollBounceBehavior(.basedOnSize)
        }
        .navigationDestination(item: $selectedPerson, destination: { person in
            orthersProfile(bandmate: person)
        })
        }
    }


#Preview {
    DiscoverUsersView()
        .environmentObject(BandMatesViewModel())
}
