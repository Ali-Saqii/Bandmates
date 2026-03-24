//
//  BandmateModel.swift
//  Bandmates
//
//  Created by Mac mini on 18/03/2026.
//

import Foundation
import Combine

struct BandmateModel: Codable,Identifiable {
    var id = UUID().uuidString
    let image : String
    let fullName : String
    let userName : String
    let Bio : String
    let bandmates: Int
    let collections: Int
    let savedCollection: [albumModel]
    var isRequested: Bool

}
