//
//  RootView.swift
//  Bandmates
//
//  Created by Mac mini on 14/04/2026.
//

import SwiftUI
struct RootView: View {
    
    @EnvironmentObject var authVm: AuthViewModel

    var body: some View {
        Group {
            if authVm.isLoggedIn {
                tabView()
            } else {
                onboardingView()
            }
        }
    }
}
