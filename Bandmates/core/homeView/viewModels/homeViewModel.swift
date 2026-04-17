//
//  homeViewModel.swift
//  Bandmates
//
//  Created by Mac mini on 19/03/2026.
//

import Foundation
import Combine
import UIKit

class HomeViewModel: ObservableObject {
    @Published var user = userModel(profileImage: "", fullName: "", userName: "", Bio: "", waiting: 0, totalBandmates: 0, toralSavedAlbums: 0, email: "", Collections: [])
    @Published var albums: [albumModel]? = nil
    @Published var searchText = ""
    @Published var recentlyplayed : [SavedAlbums] = []
    @Published var bandmates: [BandmateModel]? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    private var cancellables = Set<AnyCancellable>()
    
    private var SavedAlbums = savedAlbums()
        // MARK: - Service
        private let service = AlbumDetailsService()
    // search results
    var searchResults: (albums: [albumModel], bandmates: [BandmateModel]) {
        search(query: searchText)
    }

    var greeting: String {
        greetingMessage()
    }
    private var token: String {
         UserDefaults.standard.string(forKey: "auth_token") ?? ""
     }
     
    init() {
        getAlbums()
        getSavedAlbums()
    }
    
    
    func getAlbums() {
        guard !token.isEmpty else {
                    self.errorMessage = "No token found"
                    return
                }
        isLoading = true
        errorMessage = nil
        service.fetchTrendingAlbums(token: token)
            .sink { [weak self ] completion in
                guard let self = self else {return}
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("❌ Error:", error)
                }
            } receiveValue: {  [weak self ] albums in
                self?.albums = albums
                print("🎧 Albums loaded:", albums.count)
            }
            .store(in: &cancellables)

    }
    
    
    func addComment(commentBody: String) -> CommentModel {
        let image = user.profileImage
        let name = user.userName
        let text = commentBody
        let time = Date.now
        return CommentModel(id: "", image: image, name: name, replieText: text, replieTime: time)
        
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
    
    // openAlbumfunction
  

    func openLink(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            print("❌ Invalid URL")
            return
        }

        UIApplication.shared.open(url)
    }
    // search album and viewModel
    func search(query: String) -> (albums: [albumModel], bandmates: [BandmateModel]) {
        let trimmed = query.trimmingCharacters(in: .whitespaces).lowercased()

        guard !trimmed.isEmpty else {
//            return (albums, bandmates)
            return ([], [])  
        }
        let filteredAlbums = (albums ?? []).filter {
            $0.albumName.lowercased().contains(trimmed) ||
            $0.albumArtistName.lowercased().contains(trimmed)
        }

        let filteredBandmates = (bandmates ?? []).filter {
            $0.fullName.lowercased().contains(trimmed) ||
            $0.userName.lowercased().contains(trimmed)
        }
        return (filteredAlbums, filteredBandmates)
    }
    // share album


    func shareAlbum(_ album: albumModel) {
        let shareText = """
        🎧 Check out this album!
        
        Album: \(album.albumName)
        Artist: \(album.albumArtistName)
        Listen here: \(album.albumPlayLink)
        """
        
        guard let url = URL(string: album.albumPlayLink) else {
            print("❌ Invalid album link")
            return
        }
        
        let activityItems: [Any] = [shareText, url]
        let activityVC = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil
        )
        
        // For iPad compatibility
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = scene.windows.first?.rootViewController {
            activityVC.popoverPresentationController?.sourceView = rootVC.view
            rootVC.present(activityVC, animated: true)
        }
    }
    
    // Get saved albums
    
    func getSavedAlbums() {
        SavedAlbums.$savedAlbums
            .sink { [weak self] (returnedData)in
                self?.recentlyplayed = returnedData
            }
            .store(in: &cancellables)
    }
    func addTorecentlyPlayed(album:albumModel) {
        SavedAlbums.addAlbums(album: album)
    }
}
