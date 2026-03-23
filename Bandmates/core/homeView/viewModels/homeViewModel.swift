//
//  homeViewModel.swift
//  Bandmates
//
//  Created by Mac mini on 19/03/2026.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var user = userModel(
        profileImage: "https://randomuser.me/api/portraits/men/32.jpg",
        fullName: "Marcus Allen",
        userName: "@marcusbeats",
        Bio: "🎸 Guitarist & producer. Lover of indie rock and late-night jam sessions.",
        waiting: 5,
        totalBandmates: 128,
        toralSavedAlbums: 47,
        email: "jhjhfds@email.com"
    )
    @Published var albums: [albumModel] = [
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
                replies(image: "user3", name: "Jordan K.", replieText: "Could not agree more, been on repeat since day one.", replieTime: ISO8601DateFormatter().date(from: "2024-11-24T15:00:00Z")!),
                replies(image: "user4", name: "Priya S.", replieText: "The production is insane on this one.", replieTime: ISO8601DateFormatter().date(from: "2024-11-25T09:00:00Z")!)
            ],
            isSaved: true
        ),
        albumModel(
            image: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400"
,
            albumName: "Short n' Sweet",
            albumArtistName: "Sabrina Carpenter",
            releaseDate: ISO8601DateFormatter().date(from: "2024-08-23T00:00:00Z")!,
            averageRating: 4.6,
            totalRatingCount: 95210,
            reviews: [
                reviewsModel(personImage: "user5", personName: "Lily M.", dateOfRating: ISO8601DateFormatter().date(from: "2024-08-25T11:00:00Z")!, rating: 5.0, reviewBody: "Espresso was just the appetizer. This whole album is a bop."),
                reviewsModel(personImage: "user6", personName: "Tom H.", dateOfRating: ISO8601DateFormatter().date(from: "2024-08-26T16:00:00Z")!, rating: 4.0, reviewBody: "Catchy from start to finish. She really levelled up.")
            ],
            replies: [
                replies(image: "user7", name: "Nina P.", replieText: "Please please please is stuck in my head forever.", replieTime: ISO8601DateFormatter().date(from: "2024-08-26T17:00:00Z")!)
            ],
            isSaved: false
        ),
        albumModel(
            image: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=400"
,
            albumName: "BRAT",
            albumArtistName: "Charli XCX",
            releaseDate: ISO8601DateFormatter().date(from: "2024-06-07T00:00:00Z")!,
            averageRating: 4.7,
            totalRatingCount: 110540,
            reviews: [
                reviewsModel(personImage: "user8", personName: "Zoe W.", dateOfRating: ISO8601DateFormatter().date(from: "2024-06-09T12:00:00Z")!, rating: 5.0, reviewBody: "Club banger after club banger. BRAT summer is real."),
                reviewsModel(personImage: "user9", personName: "Sam L.", dateOfRating: ISO8601DateFormatter().date(from: "2024-06-10T18:00:00Z")!, rating: 4.5, reviewBody: "360 and Von dutch are instant classics.")
            ],
            replies: [
                replies(image: "user10", name: "Ella F.", replieText: "This album changed the entire summer aesthetic.", replieTime: ISO8601DateFormatter().date(from: "2024-06-10T19:00:00Z")!)
            ],
            isSaved: true
        ),
        albumModel(
            image: "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=400",
            albumName: "HIT ME HARD AND SOFT",
            albumArtistName: "Billie Eilish",
            releaseDate: ISO8601DateFormatter().date(from: "2024-05-17T00:00:00Z")!,
            averageRating: 4.5,
            totalRatingCount: 87650,
            reviews: [
                reviewsModel(personImage: "user1", personName: "Chris D.", dateOfRating: ISO8601DateFormatter().date(from: "2024-05-18T09:00:00Z")!, rating: 4.5, reviewBody: "Birds of a feather might be her best song ever written."),
                reviewsModel(personImage: "user2", personName: "Maya K.", dateOfRating: ISO8601DateFormatter().date(from: "2024-05-19T13:00:00Z")!, rating: 4.5, reviewBody: "Deeply personal and sonically gorgeous.")
            ],
            replies: [
                replies(image: "user3", name: "Leo B.", replieText: "Lunch is so underrated on this project.", replieTime: ISO8601DateFormatter().date(from: "2024-05-19T14:00:00Z")!)
            ],
            isSaved: false
        ),
        albumModel(
            image: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400",
            albumName: "The Tortured Poets Department",
            albumArtistName: "Taylor Swift",
            releaseDate: ISO8601DateFormatter().date(from: "2024-04-19T00:00:00Z")!,
            averageRating: 4.4,
            totalRatingCount: 204300,
            reviews: [
                reviewsModel(personImage: "user4", personName: "Hannah J.", dateOfRating: ISO8601DateFormatter().date(from: "2024-04-20T10:00:00Z")!, rating: 4.5, reviewBody: "Fortnight is a masterpiece. The anthology drop was everything."),
                reviewsModel(personImage: "user5", personName: "Ryan C.", dateOfRating: ISO8601DateFormatter().date(from: "2024-04-21T15:00:00Z")!, rating: 4.0, reviewBody: "Long but there are genuine moments of brilliance scattered throughout.")
            ],
            replies: [
                replies(image: "user6", name: "Sophie T.", replieText: "The smallest man who ever lived deserved its own album.", replieTime: ISO8601DateFormatter().date(from: "2024-04-21T16:00:00Z")!)
            ],
            isSaved: true
        ),
        albumModel(
            image: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400",
            albumName: "Alligator Bites Never Heal",
            albumArtistName: "Doechii",
            releaseDate: ISO8601DateFormatter().date(from: "2024-08-30T00:00:00Z")!,
            averageRating: 4.9,
            totalRatingCount: 76420,
            reviews: [
                reviewsModel(personImage: "user7", personName: "Darius W.", dateOfRating: ISO8601DateFormatter().date(from: "2024-09-01T11:00:00Z")!, rating: 5.0, reviewBody: "Mixtape of the decade. Anxiety alone puts her in another tier."),
                reviewsModel(personImage: "user8", personName: "Imani O.", dateOfRating: ISO8601DateFormatter().date(from: "2024-09-02T14:00:00Z")!, rating: 4.8, reviewBody: "She raps, she sings, she performs. Truly a complete artist.")
            ],
            replies: [
                replies(image: "user9", name: "Kai M.", replieText: "Nissan Altima is criminally underplayed.", replieTime: ISO8601DateFormatter().date(from: "2024-09-02T15:00:00Z")!)
            ],
            isSaved: true
        ),
        albumModel(
            image: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400",
            albumName: "MIXTAPE PLUTO",
            albumArtistName: "Future & Metro Boomin",
            releaseDate: ISO8601DateFormatter().date(from: "2024-03-29T00:00:00Z")!,
            averageRating: 4.3,
            totalRatingCount: 65800,
            reviews: [
                reviewsModel(personImage: "user10", personName: "DeShawn R.", dateOfRating: ISO8601DateFormatter().date(from: "2024-03-30T10:00:00Z")!, rating: 4.5, reviewBody: "Metro's production carries this to legendary status."),
                reviewsModel(personImage: "user1", personName: "Camille N.", dateOfRating: ISO8601DateFormatter().date(from: "2024-03-31T12:00:00Z")!, rating: 4.0, reviewBody: "We Still Don't Trust You was the real sequel we needed.")
            ],
            replies: [
                replies(image: "user2", name: "Travis Y.", replieText: "Young Metro produced this and it shows every second.", replieTime: ISO8601DateFormatter().date(from: "2024-03-31T13:00:00Z")!)
            ],
            isSaved: false
        ),
        albumModel(
            image: "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=400",
            albumName: "COWBOY CARTER",
            albumArtistName: "Beyoncé",
            releaseDate: ISO8601DateFormatter().date(from: "2024-03-29T00:00:00Z")!,
            averageRating: 4.7,
            totalRatingCount: 183900,
            reviews: [
                reviewsModel(personImage: "user3", personName: "Vanessa L.", dateOfRating: ISO8601DateFormatter().date(from: "2024-03-30T09:00:00Z")!, rating: 5.0, reviewBody: "Beyoncé just rewrote the history of country music. TEXAS HOLD EM is iconic."),
                reviewsModel(personImage: "user4", personName: "Brett H.", dateOfRating: ISO8601DateFormatter().date(from: "2024-03-31T14:00:00Z")!, rating: 4.5, reviewBody: "Daughter and Protector gave me chills. She poured everything into this.")
            ],
            replies: [
                replies(image: "user5", name: "Monique R.", replieText: "II Most Wanted with Miley was the collab of the year.", replieTime: ISO8601DateFormatter().date(from: "2024-03-31T15:00:00Z")!)
            ],
            isSaved: true
        ),
        albumModel(
            image: "https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=400",
            albumName: "For All The Dogs",
            albumArtistName: "Drake",
            releaseDate: ISO8601DateFormatter().date(from: "2023-10-06T00:00:00Z")!,
            averageRating: 3.9,
            totalRatingCount: 142100,
            reviews: [
                reviewsModel(personImage: "user6", personName: "Andre P.", dateOfRating: ISO8601DateFormatter().date(from: "2023-10-07T10:00:00Z")!, rating: 4.0, reviewBody: "Rich Flex and Hours in Silence are the highlights for me."),
                reviewsModel(personImage: "user7", personName: "Tasha B.", dateOfRating: ISO8601DateFormatter().date(from: "2023-10-08T13:00:00Z")!, rating: 3.5, reviewBody: "Has its moments but too bloated at 23 tracks.")
            ],
            replies: [
                replies(image: "user8", name: "Kevin O.", replieText: "Slime You Out was everywhere that fall.", replieTime: ISO8601DateFormatter().date(from: "2023-10-08T14:00:00Z")!)
            ],
            isSaved: false
        ),
        albumModel(
            image: "https://images.unsplash.com/photo-1463453091185-61582044d556?w=400",
            albumName: "CHROMAKOPIA",
            albumArtistName: "Tyler, the Creator",
            releaseDate: ISO8601DateFormatter().date(from: "2024-10-28T00:00:00Z")!,
            averageRating: 4.8,
            totalRatingCount: 118700,
            reviews: [
                reviewsModel(personImage: "user9", personName: "Jerome A.", dateOfRating: ISO8601DateFormatter().date(from: "2024-10-29T11:00:00Z")!, rating: 5.0, reviewBody: "Noid and St. Chroma back to back is one of the greatest album openers ever."),
                reviewsModel(personImage: "user10", personName: "Fatima S.", dateOfRating: ISO8601DateFormatter().date(from: "2024-10-30T15:00:00Z")!, rating: 4.8, reviewBody: "He keeps evolving and it never feels forced. A true artist at work.")
            ],
            replies: [
                replies(image: "user1", name: "Caleb M.", replieText: "Thought I was ready for this album. I was not.", replieTime: ISO8601DateFormatter().date(from: "2024-10-30T16:00:00Z")!)
            ],
            isSaved: true
        )
    ]
    @Published var searchText = ""
    @Published var recentlyplayed : [albumModel] = [
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
                replies(image: "user3", name: "Jordan K.", replieText: "Could not agree more, been on repeat since day one.", replieTime: ISO8601DateFormatter().date(from: "2024-11-24T15:00:00Z")!),
                replies(image: "user4", name: "Priya S.", replieText: "The production is insane on this one.", replieTime: ISO8601DateFormatter().date(from: "2024-11-25T09:00:00Z")!)
            ],
            isSaved: true
        ),
        albumModel(
            image: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400"
,
            albumName: "Short n' Sweet",
            albumArtistName: "Sabrina Carpenter",
            releaseDate: ISO8601DateFormatter().date(from: "2024-08-23T00:00:00Z")!,
            averageRating: 4.6,
            totalRatingCount: 95210,
            reviews: [
                reviewsModel(personImage: "user5", personName: "Lily M.", dateOfRating: ISO8601DateFormatter().date(from: "2024-08-25T11:00:00Z")!, rating: 5.0, reviewBody: "Espresso was just the appetizer. This whole album is a bop."),
                reviewsModel(personImage: "user6", personName: "Tom H.", dateOfRating: ISO8601DateFormatter().date(from: "2024-08-26T16:00:00Z")!, rating: 4.0, reviewBody: "Catchy from start to finish. She really levelled up.")
            ],
            replies: [
                replies(image: "user7", name: "Nina P.", replieText: "Please please please is stuck in my head forever.", replieTime: ISO8601DateFormatter().date(from: "2024-08-26T17:00:00Z")!)
            ],
            isSaved: false
        ),
        albumModel(
            image: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=400"
,
            albumName: "BRAT",
            albumArtistName: "Charli XCX",
            releaseDate: ISO8601DateFormatter().date(from: "2024-06-07T00:00:00Z")!,
            averageRating: 4.7,
            totalRatingCount: 110540,
            reviews: [
                reviewsModel(personImage: "user8", personName: "Zoe W.", dateOfRating: ISO8601DateFormatter().date(from: "2024-06-09T12:00:00Z")!, rating: 5.0, reviewBody: "Club banger after club banger. BRAT summer is real."),
                reviewsModel(personImage: "user9", personName: "Sam L.", dateOfRating: ISO8601DateFormatter().date(from: "2024-06-10T18:00:00Z")!, rating: 4.5, reviewBody: "360 and Von dutch are instant classics.")
            ],
            replies: [
                replies(image: "user10", name: "Ella F.", replieText: "This album changed the entire summer aesthetic.", replieTime: ISO8601DateFormatter().date(from: "2024-06-10T19:00:00Z")!)
            ],
            isSaved: true
        ),
        albumModel(
            image: "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=400",
            albumName: "HIT ME HARD AND SOFT",
            albumArtistName: "Billie Eilish",
            releaseDate: ISO8601DateFormatter().date(from: "2024-05-17T00:00:00Z")!,
            averageRating: 4.5,
            totalRatingCount: 87650,
            reviews: [
                reviewsModel(personImage: "user1", personName: "Chris D.", dateOfRating: ISO8601DateFormatter().date(from: "2024-05-18T09:00:00Z")!, rating: 4.5, reviewBody: "Birds of a feather might be her best song ever written."),
                reviewsModel(personImage: "user2", personName: "Maya K.", dateOfRating: ISO8601DateFormatter().date(from: "2024-05-19T13:00:00Z")!, rating: 4.5, reviewBody: "Deeply personal and sonically gorgeous.")
            ],
            replies: [
                replies(image: "user3", name: "Leo B.", replieText: "Lunch is so underrated on this project.", replieTime: ISO8601DateFormatter().date(from: "2024-05-19T14:00:00Z")!)
            ],
            isSaved: false
        )
    ]
    @Published var bandmates: [BandmateModel] = []

    var greeting: String {
        greetingMessage()
    }
    init() {
        bandmates = [
            BandmateModel(
                image: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400",
                fullName: "Marcus Thompson",
                userName: "@marcust",
                Bio: "Guitar player and producer based in LA. Into jazz, soul and indie rock.",
                bandmates: 312,
                collections: 48,
                savedCollection: Array(albums.shuffled().prefix(Int.random(in: 2...4))), isRequested: false
            ),
            BandmateModel(
                image: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400",
                fullName: "Aisha Rahman",
                userName: "@aishabeats",
                Bio: "Singer-songwriter. Lover of RnB and neo-soul. Always in the studio.",
                bandmates: 540,
                collections: 73,
                savedCollection: Array(albums.shuffled().prefix(Int.random(in: 2...4))), isRequested: false
            ),
            BandmateModel(
                image: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=400",
                fullName: "Jordan Keller",
                userName: "@jordank",
                Bio: "Drummer and beatmaker. Hip hop head. Currently working on my debut EP.",
                bandmates: 198,
                collections: 29,
                savedCollection: Array(albums.shuffled().prefix(Int.random(in: 2...4))), isRequested: false
            ),
            BandmateModel(
                image: "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=400",
                fullName: "Priya Sharma",
                userName: "@priyasings",
                Bio: "Classically trained vocalist exploring pop and electronic fusion.",
                bandmates: 421,
                collections: 61,
                savedCollection: Array(albums.shuffled().prefix(Int.random(in: 2...4))), isRequested: false
            ),
            BandmateModel(
                image: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400",
                fullName: "Tyler Reeves",
                userName: "@tylerbeats",
                Bio: "Music producer and DJ. Trap, afrobeats and everything in between.",
                bandmates: 876,
                collections: 112,
                savedCollection: Array(albums.shuffled().prefix(Int.random(in: 2...4))), isRequested: false
            ),
            BandmateModel(
                image: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400",
                fullName: "Zoe Williams",
                userName: "@zoewmusic",
                Bio: "Bassist and composer. Jazz by night, session musician by day.",
                bandmates: 267,
                collections: 44,
                savedCollection: Array(albums.shuffled().prefix(Int.random(in: 2...4))), isRequested: true
            ),
            BandmateModel(
                image: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400",
                fullName: "Darius Webb",
                userName: "@dariuswebb",
                Bio: "Multi-instrumentalist. Keys, bass and guitar. Influenced by Stevie and Prince.",
                bandmates: 633,
                collections: 89,
                savedCollection: Array(albums.shuffled().prefix(Int.random(in: 2...4))), isRequested: true
            ),
            BandmateModel(
                image: "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=400",
                fullName: "Lily Monroe",
                userName: "@lilymonroe",
                Bio: "Indie pop artist and lyricist. Writing songs about life, love and late nights.",
                bandmates: 455,
                collections: 57,
                savedCollection: Array(albums.shuffled().prefix(Int.random(in: 2...4))), isRequested: false
            ),
            BandmateModel(
                image: "https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=400",
                fullName: "Camille Fontaine",
                userName: "@camillef",
                Bio: "Vocalist and music educator. Passionate about bringing music to communities.",
                bandmates: 189,
                collections: 33,
                savedCollection: Array(albums.shuffled().prefix(Int.random(in: 2...4))), isRequested: true
            ),
            BandmateModel(
                image: "https://images.unsplash.com/photo-1463453091185-61582044d556?w=400",
                fullName: "Kai Nakamura",
                userName: "@kaidrums",
                Bio: "Percussionist blending traditional Japanese music with modern electronic sounds.",
                bandmates: 724,
                collections: 96,
                savedCollection: Array(albums.shuffled().prefix(Int.random(in: 2...4))), isRequested: false
            )
        ]
    }
    // greeting textfunction
    func greetingMessage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        let timeOfDay: String
        switch hour {
        case 5..<12:  timeOfDay = "Good Morning"
        case 12..<17: timeOfDay = "Good Afternoon"
        case 17..<24: timeOfDay = "Good Evening"
        default:      timeOfDay = "Good Night"
        }
        
        return "\(timeOfDay)!"
    }
}
