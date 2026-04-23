//
//  BandmateModel.swift
//  Bandmates
//
//  Created by Mac mini on 18/03/2026.
//

import Foundation
import Combine

struct BandmateModel: Codable,Identifiable, Hashable {
    let id : String
    let image : String
    let fullName : String
    let userName : String
    let Bio : String
    let bandmates: Int
    let collections: Int
    let isRequested : Bool
    let aretheyRequested : Bool
    let isFriend : Bool
}


struct pagination: Codable {
    let totalItems: Int
    let currentPage: Int
    let totalPages: Int
    let perPage: Int
}

struct BandmateResponse: Codable {
    let success: Bool
    let data: [BandmateModel]
    let pagination: pagination
}
