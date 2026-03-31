//
//  BandMatesViewModel.swift
//  Bandmates
//
//  Created by Mac mini on 29/03/2026.
//

import Foundation
import Combine

class BandMatesViewModel : ObservableObject {
    @Published var MyBandMates: [BandmateModel]? = []
    @Published var users: [BandmateModel]? = [
        BandmateModel(
            image: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400",
            fullName: "Marcus Thompson",
            userName: "@marcust",
            Bio: "Guitar player and producer based in LA. Into jazz, soul and indie rock.",
            bandmates: 312,
            collections: 48,
            savedCollection: [],
            BandMates: [], isRequested: false,
            aretheyRequested: false,
            isFriend: false
        ),
        BandmateModel(
            image: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400",
            fullName: "Aisha Rahman",
            userName: "@aishabeats",
            Bio: "Singer-songwriter. Lover of RnB and neo-soul. Always in the studio.",
            bandmates: 540,
            collections: 73,
            savedCollection: [],
            BandMates: [], isRequested: false,
            aretheyRequested: false,
            isFriend: false
        ),
        BandmateModel(
            image: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=400",
            fullName: "Jordan Keller",
            userName: "@jordank",
            Bio: "Drummer and beatmaker. Hip hop head. Currently working on my debut EP.",
            bandmates: 198,
            collections: 29,
            savedCollection: [],
            BandMates: [], isRequested: false,
            aretheyRequested: false,
            isFriend: true
        ),
        BandmateModel(
            image: "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=400",
            fullName: "Priya Sharma",
            userName: "@priyasings",
            Bio: "Classically trained vocalist exploring pop and electronic fusion.",
            bandmates: 421,
            collections: 61,
            savedCollection: [],
            BandMates: [],
            isRequested: false,
            aretheyRequested: false,
            isFriend: true
        ),
        BandmateModel(
            image: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400",
            fullName: "Tyler Reeves",
            userName: "@tylerbeats",
            Bio: "Music producer and DJ. Trap, afrobeats and everything in between.",
            bandmates: 876,
            collections: 112,
            savedCollection: [],
            BandMates: [],
            isRequested: false,
            aretheyRequested: false,
            isFriend: false
        ),
        BandmateModel(
            image: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400",
            fullName: "Zoe Williams",
            userName: "@zoewmusic",
            Bio: "Bassist and composer. Jazz by night, session musician by day.",
            bandmates: 267,
            collections: 44,
            savedCollection: [],
            BandMates: [],
            isRequested: true,
            aretheyRequested: false,
            isFriend: true
        )
    ]
    @Published var requestedNandmates: [BandmateModel]? = []
  
    init() {
        getRequestedNandmates()
        getMyBandMates()
    }
    private func getRequestedNandmates() {
        guard let bandmates = users else { return }
        requestedNandmates = bandmates.filter({$0.isRequested == true})
    }
    private func getMyBandMates() {
        guard let orthersUsers = users else {return}
        MyBandMates = orthersUsers.filter({$0.isFriend == true})
    }
}
