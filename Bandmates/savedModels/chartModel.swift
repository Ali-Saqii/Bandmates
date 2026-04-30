//
//  chartModel.swift
//  Bandmates
//
//  Created by Mac mini on 27/04/2026.
//

import Foundation

struct AlbumRatingsResponse: Codable {
    let success: Bool
    let message: String
    let count: Int
    let data: [AlbumRatingModel]
}


struct AlbumRatingModel: Codable, Identifiable {
    let albumId: String
    let image: String?
    let albumName : String?
    let albumArtist : String?
    let averageRating: String?
    let ratings: RatingBreakdown
    var id: String { albumId }
}

struct RatingBreakdown: Codable {
    let fiveStar: Int
    let fourStar: Int
    let threeStar: Int
    let twoStar: Int
    let oneStar: Int
}
