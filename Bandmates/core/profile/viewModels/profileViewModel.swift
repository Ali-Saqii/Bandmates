//
//  profileViewModel.swift
//  Bandmates
//
//  Created by Mac mini on 28/03/2026.
//

import Foundation
import SwiftUI
import Combine

class ProfileViewModel:ObservableObject {
    @Published var user = userModel(
        profileImage: "https://randomuser.me/api/portraits/men/32.jpg",
        fullName: "Marcus Allen",
        userName: "@marcusbeats",
        Bio: "🎸 Guitarist & producer. Lover of indie rock and late-night jam sessions.",
        waiting: 5,
        totalBandmates: 128,
        toralSavedAlbums: 47,
        email: "jhjhfds@email.com", Collections: [
            CollectionModel(collectionTitle: "bad nood", collectionDescription: "jfdsjhf dsfhdhgdf sfhdshfgdjghds", albums: [
                albumModel(
                    image: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400"
        ,
                    albumName: "GNX",
                    albumArtistName: "Kendrick Lamar",
                    releaseDate: ISO8601DateFormatter().date(from: "2024-11-22T00:00:00Z")!,
                    averageRating: 4.8,
                    totalRatingCount: 128430,
                    reviews: [
                        reviewsModel(personImage: "user1", personName: "Marcus T.", dateOfRating: ISO8601DateFormatter().date(from: "2024-11-23T10:00:00Z")!, rating: 5.0, reviewBody: "Kendrick snapped on every single track. A generational album."),
                        reviewsModel(personImage: "user2", personName: "Aisha R.", dateOfRating: ISO8601DateFormatter().date(from: "2024-11-24T14:00:00Z")!, rating: 4.5, reviewBody: "Absolutely cinematic. wacced out murals alone is top 5 of the year.")
                    ],
                    replies: [
                        CommentModel(image: "user3", name: "Jordan K.", replieText: "Could not agree more, been on repeat since day one.", replieTime: ISO8601DateFormatter().date(from: "2024-11-24T15:00:00Z")!),
                        CommentModel(image: "user4", name: "Priya S.", replieText: "The production is insane on this one.", replieTime: ISO8601DateFormatter().date(from: "2024-11-25T09:00:00Z")!)
                    ],
                    isSaved: true
                ),  albumModel(
                    image: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400"
        ,
                    albumName: "GNX",
                    albumArtistName: "Kendrick Lamar",
                    releaseDate: ISO8601DateFormatter().date(from: "2024-11-22T00:00:00Z")!,
                    averageRating: 4.8,
                    totalRatingCount: 128430,
                    reviews: [
                        reviewsModel(personImage: "user1", personName: "Marcus T.", dateOfRating: ISO8601DateFormatter().date(from: "2024-11-23T10:00:00Z")!, rating: 5.0, reviewBody: "Kendrick snapped on every single track. A generational album."),
                        reviewsModel(personImage: "user2", personName: "Aisha R.", dateOfRating: ISO8601DateFormatter().date(from: "2024-11-24T14:00:00Z")!, rating: 4.5, reviewBody: "Absolutely cinematic. wacced out murals alone is top 5 of the year.")
                    ],
                    replies: [
                        CommentModel(image: "user3", name: "Jordan K.", replieText: "Could not agree more, been on repeat since day one.", replieTime: ISO8601DateFormatter().date(from: "2024-11-24T15:00:00Z")!),
                        CommentModel(image: "user4", name: "Priya S.", replieText: "The production is insane on this one.", replieTime: ISO8601DateFormatter().date(from: "2024-11-25T09:00:00Z")!)
                    ],
                    isSaved: true
                )
            ]),
            CollectionModel(collectionTitle: "bad nood", collectionDescription: "jfdsjhf dsfhdhgdf sfhdshfgdjghds", albums: [
                albumModel(
                    image: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400"
        ,
                    albumName: "GNX",
                    albumArtistName: "Kendrick Lamar",
                    releaseDate: ISO8601DateFormatter().date(from: "2024-11-22T00:00:00Z")!,
                    averageRating: 4.8,
                    totalRatingCount: 128430,
                    reviews: [
                        reviewsModel(personImage: "user1", personName: "Marcus T.", dateOfRating: ISO8601DateFormatter().date(from: "2024-11-23T10:00:00Z")!, rating: 5.0, reviewBody: "Kendrick snapped on every single track. A generational album."),
                        reviewsModel(personImage: "user2", personName: "Aisha R.", dateOfRating: ISO8601DateFormatter().date(from: "2024-11-24T14:00:00Z")!, rating: 4.5, reviewBody: "Absolutely cinematic. wacced out murals alone is top 5 of the year.")
                    ],
                    replies: [
                        CommentModel(image: "user3", name: "Jordan K.", replieText: "Could not agree more, been on repeat since day one.", replieTime: ISO8601DateFormatter().date(from: "2024-11-24T15:00:00Z")!),
                        CommentModel(image: "user4", name: "Priya S.", replieText: "The production is insane on this one.", replieTime: ISO8601DateFormatter().date(from: "2024-11-25T09:00:00Z")!)
                    ],
                    isSaved: true
                ),  albumModel(
                    image: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400"
        ,
                    albumName: "GNX",
                    albumArtistName: "Kendrick Lamar",
                    releaseDate: ISO8601DateFormatter().date(from: "2024-11-22T00:00:00Z")!,
                    averageRating: 4.8,
                    totalRatingCount: 128430,
                    reviews: [
                        reviewsModel(personImage: "user1", personName: "Marcus T.", dateOfRating: ISO8601DateFormatter().date(from: "2024-11-23T10:00:00Z")!, rating: 5.0, reviewBody: "Kendrick snapped on every single track. A generational album."),
                        reviewsModel(personImage: "user2", personName: "Aisha R.", dateOfRating: ISO8601DateFormatter().date(from: "2024-11-24T14:00:00Z")!, rating: 4.5, reviewBody: "Absolutely cinematic. wacced out murals alone is top 5 of the year.")
                    ],
                    replies: [
                        CommentModel(image: "user3", name: "Jordan K.", replieText: "Could not agree more, been on repeat since day one.", replieTime: ISO8601DateFormatter().date(from: "2024-11-24T15:00:00Z")!),
                        CommentModel(image: "user4", name: "Priya S.", replieText: "The production is insane on this one.", replieTime: ISO8601DateFormatter().date(from: "2024-11-25T09:00:00Z")!)
                    ],
                    isSaved: true
                )
            ])
        ]
    )
}
