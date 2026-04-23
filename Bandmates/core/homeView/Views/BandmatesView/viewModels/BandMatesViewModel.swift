//
//  BandMatesViewModel.swift
//  Bandmates
//
//  Created by Mac mini on 29/03/2026.
//

import Foundation
import Combine

class BandMatesViewModel : ObservableObject {
    @Published var MyBandMates: [BandmateModel]? = nil
    @Published var users: [BandmateModel]? = nil
    @Published var requestedNandmates: [BandmateModel]? = nil
  
    @Published var isLoading: Bool = false
    @Published var isFetchingMore: Bool = false
    @Published var isSavedAlbumFetched = false
    @Published var errorMessage: String?
    @Published var successMessage: String?

    // MARK: - Pagination
    private(set) var currentPage: Int = 1
    private(set) var totalPages: Int = 1
    private let limit: Int = 10

    // MARK: - Dependencies
    private let userService = BandmateClass()
    private var cancellables = Set<AnyCancellable>()


    init() {
        fetchUsers()
        getRequestedNandmates()
        getMyBandMates()
        
    }
    
    // MARK: - Initial Fetch
       func fetchUsers() {

           isLoading = true
           errorMessage = nil
           successMessage = nil

           currentPage = 1
           totalPages = 1

           userService.fetchUsers(page: currentPage, limit: limit)
               .sink { [weak self] completion in
                   guard let self else { return }

                   self.isLoading = false

                   if case .failure(let error) = completion {
                       print("❌ Fetch Users Error:", error)
                       self.errorMessage = error.localizedDescription
                   }

               } receiveValue: { [weak self] response in
                   guard let self else { return }

                   self.users = response.data
                   self.totalPages = response.pagination.totalPages
                   self.isSavedAlbumFetched = true
                   if response.data.isEmpty {
                       self.users = response.data
                       self.successMessage = "No users found."
                   }
               }
               .store(in: &cancellables)
       }

       // MARK: - Pagination (Load More)
       func loadMoreIfNeeded(currentItem: BandmateModel) {

           guard !isFetchingMore,
                 currentPage < totalPages else { return }

           // Trigger when last item appears
           if currentItem.id == users?.last?.id {

               isFetchingMore = true
               currentPage += 1

               userService.fetchUsers(page: currentPage, limit: limit)
                   .sink { [weak self] completion in
                       guard let self else { return }

                       self.isFetchingMore = false

                       if case .failure(let error) = completion {
                           print("❌ Load More Error:", error)
                           self.errorMessage = error.localizedDescription
                       }

                   } receiveValue: { [weak self] response in
                       guard let self else { return }

                       self.users?.append(contentsOf: response.data)
                       self.totalPages = response.pagination.totalPages
                   }
                   .store(in: &cancellables)
           }
       }

     
       func refresh() {
           fetchUsers()
       }

      
       func reset() {
           users?.removeAll()
           currentPage = 1
           totalPages = 1
           errorMessage = nil
           successMessage = nil
       }
    
    
    private func getRequestedNandmates() {
        guard let bandmates = users else { return }
        requestedNandmates = bandmates.filter({$0.isRequested == true})
    }
    private func getMyBandMates() {
        guard let orthersUsers = users else {return}
        MyBandMates = orthersUsers.filter({$0.isFriend == true})
    }
    
    
    // getusers Collection
    
     @Published var userSavedAlbums: [albumModel] = []
     @Published var SavedAlbumErrorMessage: String?

     var SavedAlbumCurrentPage = 1
     var total = 0
     let SavedAlbumLimit = 10

     private let service = SaveAlbumService()

    private var token : String {
        UserDefaults.standard.string(forKey: "auth_token") ?? ""
    }

    func fetchSavedAlbums(userId: String) {

         isLoading = true
         SavedAlbumErrorMessage = nil

         service.fetchSavedAlbums(
             userId: userId,
             token: token,
             page: currentPage,
             limit: limit
         )
         .sink { [weak self] completion in
             guard let self else { return }

             self.isLoading = false

             if case .failure(let error) = completion {
                 print("❌ Album Fetch Error:", error)
                 self.errorMessage = error.localizedDescription
             }

         } receiveValue: { [weak self] response in
             guard let self else { return }

             self.total = response.total

             if self.currentPage == 1 {
                 self.userSavedAlbums = response.data
             } else {
                 self.userSavedAlbums.append(contentsOf: response.data)
             }
         }
         .store(in: &cancellables)
     }

     // MARK: - PAGINATION
    func loadMore(currentItem item: albumModel,userId:String) {

         guard let last = userSavedAlbums.last,
               !isLoading,
               userSavedAlbums.count < total else { return }

         if item.id == last.id {
             currentPage += 1
             fetchSavedAlbums(userId: userId)
         }
     }

     // MARK: - REFRESH
     func SavedAlbumRefresh(userId:String) {
         currentPage = 1
         total = 0
         fetchSavedAlbums(userId: userId)
     }
}
