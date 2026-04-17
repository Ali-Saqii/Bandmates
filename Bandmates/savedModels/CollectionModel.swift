//
//  CollectionModel.swift
//  Bandmates
//
//  Created by Mac mini on 26/03/2026.
//

import Foundation
import Combine

struct CollectionModel: Codable,Identifiable,Hashable {
    let id : String
    let collectionTitle: String
    let collectionDescription: String
    let albums:[albumModel]
}
