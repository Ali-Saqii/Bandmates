//
//  profileViewModel.swift
//  Bandmates
//
//  Created by Mac mini on 28/03/2026.
//

import Foundation
import SwiftUI
import Combine

class ProfileViewModel:ObservableObject {
    @Published var user: userModel? = nil
}
