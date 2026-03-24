//
//  albumModel.swift
//  Bandmates
//
//  Created by Mac mini on 18/03/2026.
//

import Foundation
import Combine

struct albumModel: Codable, Identifiable,Hashable {
    var id = UUID().uuidString
    let image : String
    let albumName : String
    let albumArtistName  : String
    let releaseDate : Date
    let averageRating : Double
    let totalRatingCount : Int
    let reviews: [reviewsModel]
    let replies: [replies]
    var isSaved: Bool
    let albumPlayLink : String = "vcgvb"
}

struct reviewsModel: Codable ,Identifiable, Hashable {
    var id = UUID().uuidString
    let personImage : String
    let personName : String
    let dateOfRating : Date
    let rating : Double
    let reviewBody : String
}

struct replies: Codable, Identifiable, Hashable {
    var id = UUID().uuidString
    let image: String
    let name: String
    let replieText : String
    let replieTime : Date
}
