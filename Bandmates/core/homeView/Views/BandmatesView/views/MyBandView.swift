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
            ScrollView {
                VStack{
                    if let Bandmates = Bvm.MyBandMates {
                        ForEach(Bandmates) { mate in
                            MyBandRowView(personImage: mate.image, fullName: mate.fullName, userName: mate.userName)
                                .onTapGesture {
                                    selectedPerSon = mate
                                }
                        }
                    }
                }.padding(.horizontal)
            }.scrollIndicators(.hidden)
                .scrollBounceBehavior(.basedOnSize)
                .navigationDestination(item: $selectedPerSon, destination: { person in
                    orthersProfile(bandmate: person)
                })
         
        }
    }
}

#Preview {
    MyBandView()
        .environmentObject(BandMatesViewModel())
}
