//
//  personBandMateView.swift
//  Bandmates
//
//  Created by Mac mini on 30/03/2026.
//

import SwiftUI

struct personBandMateView: View {
    @EnvironmentObject var Bvm : BandMatesViewModel
    let name: String
    @State private var selectedMate: BandmateModel? = nil
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    if !Bvm.userBnadmates.isEmpty {
                        ForEach(Bvm.userBnadmates) { bandmate in
                            MyBandRowView(personImage: bandmate.image, fullName: bandmate.fullName, userName: bandmate.userName)
                                .padding(.horizontal)
                                .onTapGesture {
                                    Bvm.fetchSavedAlbums(userId: bandmate.id)
                                    if Bvm.isSavedAlbumFetched {
                                        selectedMate = bandmate
                                    }
                                }
                        }
                        
                    } else {
                        NoBandmatesView(icon: "figure.2",height: 70,width: 100, title: "User have no band", subTitle: "", titleFont: .dmSans(20, weight: .semiBold),subTitleFont: .dmSans(14, weight: .medium), color: Color.background.opacity(0.5))
                        
                 
                    }
                }
            }.scrollIndicators(.hidden)
                
        }.navigationTitle("\(name)'s Bandmates")
            .navigationDestination(item: $selectedMate) { mate in
                orthersProfile(bandmate: mate)
                    .environmentObject(Bvm)
            }
    }
}

#Preview {
    personBandMateView(name: DeveloperPreview.instance.profile.fullName)
        .environmentObject(BandMatesViewModel())
}
