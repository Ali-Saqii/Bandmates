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
    
    
    // TO THIS:
    enum CodingKeys: String, CodingKey {
        case id
        case collectionTitle                        // ← matches backend directly
        case collectionDescription                  // ← matches backend directly
        case albums = "savedAlbums"                 // ← keep this one
    }
}
struct CollectionResponse: Codable {
    let success: Bool
    let message: String
    let data: [CollectionModel]
    let pagination: Pagination
}

struct Pagination: Codable {
    let totalItems: Int
    let currentPage: Int
    let totalPages: Int
    let perPage: Int
}
struct CreateCollectionBody: Encodable {
    let name: String
    let description: String
}
