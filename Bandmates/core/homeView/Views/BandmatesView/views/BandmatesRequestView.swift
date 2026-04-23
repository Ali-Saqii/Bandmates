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
            if Bvm.requestedNandmates != nil {
                ScrollView {
                    VStack {
                        if let requestedMates = Bvm.requestedNandmates {
                            ForEach(requestedMates) { mate in
                                RequestedBandmatesRowView(personImage: mate.image, fullName: mate.fullName, userName: mate.userName, DeclineButton: {}, ApproveButton: {})
                            }
                        }
                    }.padding(.horizontal)
                }.refreshable {
                    Bvm.refresh()
                }
                .scrollIndicators(.hidden)
                    .scrollBounceBehavior(.basedOnSize)
                    .background(
                        Color.white
                            .ignoresSafeArea()
                    )
            } else {
                NoBandmatesView(icon: "questionmark.message.fill",height: 70,width: 80, title: "No friend requests yet", subTitle: "You’ll see bandmate requests here once someone sends you one.", titleFont:.dmSans(20, weight: .semiBold), subTitleFont: .dmSans(14, weight: .medium), color: Color.background.opacity(0.5))
            }
        }
    }
}
#Preview {
    BandmatesRequestView()
        .environmentObject(BandMatesViewModel())
}
