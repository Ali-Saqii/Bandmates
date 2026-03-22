//
//  userModel.swift
//  Bandmates
//
//  Created by Mac mini on 18/03/2026.
//

import Foundation
import Combine

struct userModel: Codable ,Identifiable {
    var id  = UUID().uuidString
    let profileImage : String
    let fullName: String
    let userName: String
    let Bio: String
    let waiting: Int
    let totalBandmates: Int
    let toralSavedAlbums: Int
}
