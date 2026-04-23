//
//  collectionModel.swift
//  Bandmates
//
//  Created by Mac mini on 16/04/2026.
//

import Foundation
import Combine

class collectionViewModel:ObservableObject {
    
    @Published var collections:[CollectionModel]? = nil
    @Published var user = userModel(id: "", profileImage: "", fullName: "", userName: "", Bio: "", waiting: 0, totalBandmates: 0, toralSavedAlbums: 0, email: "", subscriptionPlan: "club", isOnTrial: false)
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var cErrorMessage: String? = nil
    @Published var successMessage: String? = nil
     @Published var currentPage: Int       = 1
     @Published var totalPages: Int        = 1
     @Published var isFetchingMore: Bool   = false
    
    
    
    private let collectionClass = CollectionClass()
    private let userClass    = UserClass()
    private let AlumClass    = AlbumDetailsService()
    private var cancellables = Set<AnyCancellable>()
    init(){
        fetchProfile()
        fetchCollections()
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
 
    
    // ── Fetch Collections (first page) ────────────────────────────────────────
    func fetchCollections() {
        isLoading      = true
        errorMessage   = nil
        cErrorMessage = nil
        currentPage    = 1

        collectionClass.getUserCollections(page: 1)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print("error: \(error)")
                    self?.cErrorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.collections    = response.data
                self.totalPages     = response.pagination.totalPages
                self.successMessage = response.data.isEmpty ? "No collections yet." : nil
            })
            .store(in: &cancellables)
    }
    
    // ── Load More (pagination) ────────────────────────────────────────────────
    func loadMoreIfNeeded(currentItem: CollectionModel) {
        guard !isFetchingMore, currentPage < totalPages else { return }

        // trigger when last item appears
        if currentItem.id == collections?.last?.id {
            isFetchingMore = true
            currentPage   += 1

            collectionClass.getUserCollections(page: currentPage)
                .sink(receiveCompletion: { [weak self] completion in
                    self?.isFetchingMore = false
                    if case .failure(let error) = completion {
                        self?.cErrorMessage = error.localizedDescription
                    }
                }, receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    self.collections?.append(contentsOf: response.data)
                    self.totalPages = response.pagination.totalPages
                })
                .store(in: &cancellables)
        }
    }
    // create collection
    @Published var cCErrorMessage: String? = nil

    func createCollection(title: String, description: String) {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Collection name is required."
            return
        }
        
        isLoading      = true
        cCErrorMessage   = nil
        successMessage = nil
        
        collectionClass.createCollection(name: title, description: description)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print("error:\(error)")
                    self?.cCErrorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.successMessage = response.message
                self.fetchCollections() 
            })
            .store(in: &cancellables)
    }
    // ── Delete Collection ──────────────────────────────────────────────────────────
    @Published var isDeleted = false
    func deleteCollection(id: String) {
        isLoading    = true
        errorMessage = nil

        collectionClass.deleteCollection(id: id)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print(error)
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.successMessage = response.message
                self.isDeleted = response.success
                self.collections?.removeAll { $0.id == id } // ← remove locally, no refetch needed
            })
            .store(in: &cancellables)
    }
    //update collection
    @Published var isUpdated = false
    func updateCollection(id: String, name: String, description: String) {
        isLoading    = true
        errorMessage = nil

        collectionClass.updateCollection(id: id, name: name, description: description)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print(error)
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.successMessage = response.message
                self.isUpdated = response.success
                // ← update locally without refetch
                if let index = self.collections?.firstIndex(where: { $0.id == id }) {
                    let old = self.collections![index]
                    self.collections?[index] = CollectionModel(
                        id: old.id,
                        collectionTitle: name.isEmpty ? old.collectionTitle : name,
                        collectionDescription: description.isEmpty ? old.collectionDescription : description,
                        albums: old.albums
                    )
                }
            })
            .store(in: &cancellables)
    }
    
    // MARK: - Remove Album
    @Published var removeAlbumSuccess: Bool    = false
    @Published var removeAlbumError  : String? = nil

    private var token: String {
         UserDefaults.standard.string(forKey: "auth_token") ?? ""
     }
    
    
    func removeAlbum(albumId: String, collectionId: String) {
        guard !token.isEmpty else {
            removeAlbumError = "No token found"
            return
        }
        
        isLoading         = true
        removeAlbumError  = nil
        removeAlbumSuccess = false
        
        AlumClass.removeAlbum(albumId: albumId, collectionId: collectionId, token: token)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.removeAlbumError = error.localizedDescription
                    print("❌ Remove Album Error:", error.localizedDescription)
                }
            }, receiveValue: { [weak self] success in
                self?.isLoading          = false
                self?.removeAlbumSuccess = success
                if success {
                    print("✅ Album removed successfully")
                    self?.fetchCollections()
                }
            })
            .store(in: &cancellables)
    }
}

