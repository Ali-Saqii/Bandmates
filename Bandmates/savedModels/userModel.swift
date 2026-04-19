//
//  userModel.swift
//  Bandmates
//
//  Created by Mac mini on 18/03/2026.
//

import Foundation
import Combine

struct userModel: Codable ,Identifiable, Hashable {
    var id  = UUID().uuidString
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
    let userId              : String
    let userProfileImage    : String
    let userName            : String
    let userDisplayName     : String
    let email               : String
    let bio                 : String
    let noOfFriends         : Int
    let numberOfSavedAlbums : Int
    let userMembeShip       : String
    let isOnTrial           : Bool
    let totalUsers          : Int
}

// MARK: - UserDTO → userModel
extension UserDTO {
    func toUserModel() -> userModel {
        userModel(
            id              : userId,
            profileImage    : userProfileImage,
            fullName        : userDisplayName.isEmpty ? userName : userDisplayName,
            userName        : userName,
            Bio             : bio,
            waiting         : 0,
            totalBandmates  : noOfFriends,
            toralSavedAlbums: numberOfSavedAlbums,
            email           : email,
            subscriptionPlan: userMembeShip,
            isOnTrial       : isOnTrial
        )
    }
}

// MARK: - API Response Wrapper
struct UserResponse: Codable {
    let sucess : Bool           // keeping your API's spelling
    let message: String
    let data   : UserDTO?       // ✅ UserDTO not userModel — maps JSON keys correctly
}


