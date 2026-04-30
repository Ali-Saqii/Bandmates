//
//  delegate.swift
//  Bandmates
//
//  Created by Mac mini on 28/04/2026.
//

import Foundation
import SwiftUI
import Combine
enum AppRoute {
    case notifications
    case bandmates
    case collection
    case album(id: String)
}

class NavigationRouter: ObservableObject {
    static let shared = NavigationRouter()
    @Published var activeRoute: AppRoute?
    
    func navigate(to route: AppRoute) {
        DispatchQueue.main.async {
            self.activeRoute = route
        }
    }
}
