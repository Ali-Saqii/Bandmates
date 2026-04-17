//
//  albumModel.swift
//  Bandmates
//
//  Created by Mac mini on 18/03/2026.
//

import Foundation
import Combine

struct AlbumResponse: Codable {
    let success: Bool
    let plan: String
    let total: Int
    let data: [albumModel]
}

struct albumModel: Codable, Identifiable,Hashable {
    let id: String
    let image : String
    let albumName : String
    let albumArtistName  : String
    let releaseDate : Date
    let averageRating : Double
    let totalRatingCount : Int
    let reviews: [reviewsModel]
    let replies: [CommentModel]
    var isSaved: Bool
    let albumPlayLink : String 
}

struct reviewsModel: Codable ,Identifiable, Hashable {
    let id: String
    let personImage : String
    let personName : String
    let dateOfRating : Date
    let rating : Double
    let reviewBody : String
}

struct CommentModel: Codable, Identifiable, Hashable {
    let id: String
    let image: String
    let name: String
    let replieText : String
    let replieTime : Date
}
