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
    @Published var user = userModel(profileImage: "", fullName: "", userName: "", Bio: "", waiting: 0, totalBandmates: 0, toralSavedAlbums: 0, email: "",subscriptionPlan: "club",isOnTrial:false)
    @Published var albums: [albumModel]? = nil
    @Published var searchText = ""
    @Published var recentlyplayed : [SavedAlbums] = []
    @Published var bandmates: [BandmateModel]? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    private var cancellables = Set<AnyCancellable>()
    private let userClass    = UserClass()
    private var SavedAlbums = savedAlbums()
    private var collectionsClass = CollectionClass()
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
        fetchProfile()
        fetchAndMapCollections()
    }
    @MainActor
     func fetchItems() async {
         // call API here
         try? await Task.sleep(nanoseconds: 1_500_000_000)
        fetchProfile()
         getAlbums()
     }
 
    
    func fetchProfile() {
        isLoading     = true
        errorMessage  = nil

        userClass.getUser()
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] user in
                self?.user = user
            })
            .store(in: &cancellables)
    }
    
    
    //get album
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
        return CommentModel(id: "", image: image, name: name, disPlayName: "gfgf", replieText: text, replieTime: time)
        
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
    
    
    // post review
    
    
    // MARK: - Published
    @Published var reviewSuccess : Bool    = false
    @Published var reviewError   : String? = nil

    // MARK: - POST Review
    func postReview(
        albumId    : String,
        rating     : Int,
        reviewText : String
    ) {
        guard !token.isEmpty else {
            reviewError = "No token found"
            return
        }
        
        isLoading     = true
        reviewError   = nil
        reviewSuccess = false

        service.postReview(
            albumId    : albumId,
            rating     : rating,
            reviewText : reviewText,
            token      : token
        )
        .sink(receiveCompletion: { [weak self] completion in
            self?.isLoading = false
            if case .failure(let error) = completion {
                self?.reviewError = error.localizedDescription
                print("❌ Review Error:", error.localizedDescription)
            }
        }, receiveValue: { [weak self] success in
            self?.isLoading     = false
            self?.reviewSuccess = success
            if success {
                print("✅ Review posted successfully")
            }
        })
        .store(in: &cancellables)
    }
    
    // post comment
   
    @Published var commentSuccess : Bool    = false
    @Published var commentError   : String? = nil

    // MARK: - POST Comment
    func postComment(
        albumId  : String,
        text     : String,
        parentId : String? = nil    // ✅ nil = new comment, id = reply
    ) {
        guard !token.isEmpty else {
            commentError = "No token found"
            return
        }

        isLoading      = true
        commentError   = nil
        commentSuccess = false

        service.postComment(
            albumId  : albumId,
            text     : text,
            parentId : parentId,
            token    : token
        )
        .sink(receiveCompletion: { [weak self] completion in
            self?.isLoading = false
            if case .failure(let error) = completion {
                self?.commentError = error.localizedDescription
                print("❌ Comment Error:", error.localizedDescription)
            }
        }, receiveValue: { [weak self] success in
            self?.isLoading      = false
            self?.commentSuccess = success
        })
        .store(in: &cancellables)
    }
    
    // get collections
    @Published var mapedCollection: [MapedCollection]  = []

    func fetchAndMapCollections() {
        collectionsClass.getMappedCollections()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print(error)
                    print("❌ MappedCollections error:", error.localizedDescription)
                }
            }, receiveValue: { [weak self] mapped in
                self?.mapedCollection = mapped
                print("✅ Mapped collections:", mapped.map { $0.title })
            })
            .store(in: &cancellables)
    }
    
    
    // MARK: - Save Album
    @Published var saveAlbumSuccess: Bool    = false
    @Published var saveAlbumError  : String? = nil
    @Published var isAlbumSaved = false
    
    func saveAlbum(albumId: String, collectionId: String) {
        guard !token.isEmpty else {
            saveAlbumError = "No token found"
            return
        }
        
        isLoading       = true
        saveAlbumError  = nil
        saveAlbumSuccess = false
        
        service.saveAlbum(albumId: albumId, collectionId: collectionId, token: token)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print(error)
                    self?.saveAlbumError = error.localizedDescription
                    print("❌ Save Album Error:", error.localizedDescription)
                }
            }, receiveValue: { [weak self] success in
                self?.isLoading        = false
                self?.saveAlbumSuccess = success
                if success {
                    print("✅ Album saved successfully")
                    self?.isAlbumSaved = true
                    self?.fetchAndMapCollections() // ← refresh collections
                    
                }
            })
            .store(in: &cancellables)
    }

 
}
