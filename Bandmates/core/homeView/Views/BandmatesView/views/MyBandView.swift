//
//  MyBandView.swift
//  Bandmates
//
//  Created by Mac mini on 23/03/2026.
//

import SwiftUI

struct MyBandView: View {
    @EnvironmentObject private var Bvm : BandMatesViewModel
    @State private var selectedPerSon: BandmateModel?  = nil
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            if Bvm.MyBandMates != nil && Bvm.MyBandMates != [] {
            ScrollView {
                
                    VStack{
                        if let Bandmates = Bvm.MyBandMates {
                            ForEach(Bandmates) { mate in
                                MyBandRowView(personImage: mate.image, fullName: mate.fullName, userName: mate.userName)
                                    .onTapGesture {
                                        Bvm.fetchSavedAlbums(userId: mate.id)
                                        if Bvm.isSavedAlbumFetched {
                                            Bvm.isSavedAlbumFetched = false
                                            selectedPerSon = mate
                                        }
                                    }
                            }
                        }
                    }.padding(.horizontal)
              
            }.refreshable {
                Bvm.refresh()
            }
            .scrollIndicators(.hidden)
                .scrollBounceBehavior(.basedOnSize)
                .navigationDestination(item: $selectedPerSon, destination: { person in
                    orthersProfile(bandmate: person)
                        .environmentObject(Bvm)
                })
                
            } else {
                VStack(spacing:20) {
                    NoBandmatesView(icon: "figure.2",height: 70,width: 100, title: "You have no band", subTitle: "Start requesting with other music lovers to build your band!", titleFont: .dmSans(20, weight: .semiBold),subTitleFont: .dmSans(14, weight: .medium), color: Color.background.opacity(0.5))
                    
                    buttonView(action: {}, buttonText: "Discover Bandmates", height: 55)
                        .padding(.horizontal,70)
                }
                
            }
         
        }
    }
}

#Preview {
    MyBandView()
        .environmentObject(BandMatesViewModel())
}
