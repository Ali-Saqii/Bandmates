//
//  searchBandmates.swift
//  Bandmates
//
//  Created by Mac mini on 31/03/2026.
//

import SwiftUI

struct searchBandmates: View {
    @EnvironmentObject var hvm : HomeViewModel
    @State private var selecteMate: BandmateModel? = nil
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            ScrollView {
                VStack {
                    Text("Bandmates")
                        .foregroundStyle(.black)
                        .font(.dmSans(20, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if !hvm.searchResults.bandmates.isEmpty {
                        ForEach(hvm.searchResults.bandmates) { mate in
                            OrtherUsersRowView(personImage: mate.image, PersonName: mate.fullName, personUserName: mate.userName, isRequested:mate.isRequested, buttonAction: {})
                                .onTapGesture {
                                    selecteMate = mate
                                }
                        }
                    } else {}
                }.padding(.horizontal)
            }.scrollIndicators(.hidden)
                .scrollBounceBehavior(.basedOnSize)
                .navigationDestination(item: $selecteMate) { mate in
                    orthersProfile(bandmate: mate)
                        .environmentObject(hvm)
                }
        }
    }
}

#Preview {
    searchBandmates()
        .environmentObject(HomeViewModel())
}
