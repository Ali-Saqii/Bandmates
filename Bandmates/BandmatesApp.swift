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
    @StateObject var authVM = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
                    .environmentObject(vm)
                    .environmentObject(authVM)
                    .onAppear {
                        authVM.checkAuthStatus()
                    }
            }
        }
    }
}
