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
    @StateObject private var Bvm = BandMatesViewModel()
    var body: some View {
        ZStack {
          
                VStack {
                    BandematesViewHeader(selectedTab: $selectedTab)
                    switch selectedTab {
                    case .myBand:       MyBandView()
                            .transition(transition)
                            .environmentObject(Bvm)
                    case .request: BandmatesRequestView()
                            .transition(transition)
                            .environmentObject(Bvm)
                    case .discover:     DiscoverUsersView()
                            .transition(transition)
                            .environmentObject(Bvm)
                        
                    }
                }
            
        }.navigationTitle("Bandmates")
            .navigationBarTitleDisplayMode(.inline)
            .environmentObject(Bvm)
    }
    var transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing).animation(.easeIn), removal: .move(edge: .leading).animation(.easeIn))

}

#Preview {
    Bandmates()
        .environmentObject(HomeViewModel())
}
