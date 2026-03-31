//
//  BandmatesRequestView.swift
//  Bandmates
//
//  Created by Mac mini on 23/03/2026.
//

import SwiftUI

struct BandmatesRequestView: View {
    @EnvironmentObject var Bvm : BandMatesViewModel
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    if let requestedMates = Bvm.requestedNandmates {
                        ForEach(requestedMates) { mate in
                            RequestedBandmatesRowView(personImage: mate.image, fullName: mate.fullName, userName: mate.userName, DeclineButton: {}, ApproveButton: {})
                        }
                    }
                }.padding(.horizontal)
            }.scrollIndicators(.hidden)
                .scrollBounceBehavior(.basedOnSize)
                .background(
                    Color.white
                        .ignoresSafeArea()
                )
        }
    }
}
#Preview {
    BandmatesRequestView()
        .environmentObject(BandMatesViewModel())
}
