//
//  Bandmates.swift
//  Bandmates
//
//  Created by Mac mini on 23/03/2026.
//

import SwiftUI
enum BandmatesviewTabs: Int, CaseIterable {
    case myBand, request, discover
 
    var title: String {
        switch self {
        case .myBand :       return "My Band"
        case .request : return "Request"
        case .discover:      return "Discover"
        }
    }

}
struct Bandmates: View {
    @State private var selectedTab: BandmatesviewTabs = .myBand
    @EnvironmentObject var hvm: HomeViewModel

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea(edges: .all)
            VStack {
             BandematesViewHeader(selectedTab: $selectedTab)
                switch selectedTab {
                case .myBand:       MyBandView()
                case .request: BandmatesRequestView()
                case .discover:     DiscoverBandmatesView()
              
                }
            }
        }.navigationTitle("Bandmates")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    Bandmates()
        .environmentObject(HomeViewModel())
}
