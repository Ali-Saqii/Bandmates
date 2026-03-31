//
//  BandmateModel.swift
//  Bandmates
//
//  Created by Mac mini on 18/03/2026.
//

import Foundation
import Combine

struct BandmateModel: Codable,Identifiable, Hashable {
    var id = UUID().uuidString
    let image : String
    let fullName : String
    let userName : String
    let Bio : String
    let bandmates: Int
    let collections: Int
    let savedCollection: [CollectionModel]
    let BandMates: [BandmateModel]
    let isRequested : Bool
    let aretheyRequested : Bool
    let isFriend : Bool

}
