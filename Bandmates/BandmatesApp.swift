//
//  BandmatesApp.swift
//  Bandmates
//
//  Created by Mac mini on 25/02/2026.
//

import SwiftUI

@main
struct BandmatesApp: App {
    @StateObject var vm: HomeViewModel = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                tabView()
                    .environmentObject(HomeViewModel())
            }
        }
    }
}
