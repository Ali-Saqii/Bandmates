//
//  userModel.swift
//  Bandmates
//
//  Created by Mac mini on 18/03/2026.
//

import Foundation
import Combine

struct userModel: Codable ,Identifiable, Hashable {
    let  id : String
    let profileImage : String
    let fullName: String
    let userName: String
    let Bio: String
    let waiting: Int
    let totalBandmates: Int
    let toralSavedAlbums: Int
    let email: String
    let subscriptionPlan: String
    let isOnTrial: Bool
}
struct AuthResponse: Codable {
    let success: Bool
    let message: String?
    let token:   String?
    let errors:  [String: String]?
}


struct UserDTO: Codable {
    let id               : String
    let profileImage     : String
    let fullName         : String
    let userName         : String
    let Bio              : String
    let waiting          : Int
    let totalBandmates   : Int
    let toralSavedAlbums : Int
    let email            : String
    let subscriptionPlan : String
    let isOnTrial        : Bool
}

// MARK: - UserDTO → userModel
extension UserDTO {
    func toUserModel() -> userModel {
        userModel(
            id: id,
            profileImage    : profileImage,
            fullName        : fullName,
            userName        : userName,
            Bio             : Bio,
            waiting         : waiting,
            totalBandmates  : totalBandmates,
            toralSavedAlbums: toralSavedAlbums,
            email           : email,
            subscriptionPlan: subscriptionPlan,
            isOnTrial       : isOnTrial
        )
    }
}

// MARK: - API Response Wrapper
struct UserResponse: Codable {
    let success : Bool           // keeping your API's spelling
    let message: String
    let data   : UserDTO?       // ✅ UserDTO not userModel — maps JSON keys correctly
}


