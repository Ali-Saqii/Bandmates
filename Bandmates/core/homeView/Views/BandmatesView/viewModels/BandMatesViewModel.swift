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
    @Published var userBnadmates: [BandmateModel] = []
    @Published var isLoading: Bool = false
    @Published var isFetchingMore: Bool = false
    @Published var isSavedAlbumFetched = false
    @Published var errorMessage: String?
    @Published var successMessage: String?
    
    private(set) var currentPage: Int = 1
    private(set) var totalPages: Int = 1
    private let limit: Int = 10
    
    private let userService = BandmateClass()
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        fetchUsers()
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

                   self.users = response.data.filter {
                       !$0.isFriend && !$0.aretheyRequested
                   }
                   self.requestedNandmates = response.data.filter { $0.aretheyRequested == true }
                   self.MyBandMates = response.data.filter { $0.isFriend == true }
                   self.totalPages = response.pagination.totalPages
             
                   if response.data.isEmpty {
                       self.users = response.data
                       self.successMessage = "No users found."
                   }
               }
               .store(in: &cancellables)
       }

       // Load More
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
                       self.requestedNandmates = response.data.filter { $0.aretheyRequested == true }
                       self.MyBandMates = response.data.filter { $0.isFriend == true }

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
                 self.isSavedAlbumFetched = false

             }

         } receiveValue: { [weak self] response in
             guard let self else { return }

             self.total = response.total
             self.isSavedAlbumFetched = true

             if self.currentPage == 1 {
                 self.userSavedAlbums = response.data
             } else {
                 self.userSavedAlbums.append(contentsOf: response.data)
             }
         }
         .store(in: &cancellables)
     }

     //  PAGINATION
    func loadMore(currentItem item: albumModel,userId:String) {

         guard let last = userSavedAlbums.last,
               !isLoading,
               userSavedAlbums.count < total else { return }

         if item.id == last.id {
             currentPage += 1
             fetchSavedAlbums(userId: userId)
         }
     }

     // REFRESH
     func SavedAlbumRefresh(userId:String) {
         currentPage = 1
         total = 0
         fetchSavedAlbums(userId: userId)
     }
    
    // get user's bandmates
    
    @Published var isFriendsGet = false
    
    func fetchBandmates(userId: String) {

          isLoading = true
          errorMessage = nil
          currentPage = 1

          userService.fetchBandmates(
              userId: userId,
              page: currentPage,
              limit: limit
          )
          .sink { [weak self] completion in
              self?.isLoading = false

              if case .failure(let error) = completion {
                  print("Error: \(error)")
                  self?.errorMessage = error.localizedDescription
              }

          } receiveValue: { [weak self] response in
              guard let self else { return }
              self.isFriendsGet = response.success
              self.userBnadmates = response.data
              self.totalPages = response.pagination.totalPages
          }
          .store(in: &cancellables)
      }

      // Pagination
    func loadMoreFriendsIfNeeded(currentItem: BandmateModel,userId:String) {

          guard !isFetchingMore,
                currentPage < totalPages else { return }

          if currentItem.id == userBnadmates.last?.id {

              isFetchingMore = true
              currentPage += 1

              userService.fetchBandmates(
                  userId: userId,
                  page: currentPage,
                  limit: limit
              )
              .sink { [weak self] completion in
                  self?.isFetchingMore = false

                  if case .failure(let error) = completion {
                      self?.errorMessage = error.localizedDescription
                  }

              } receiveValue: { [weak self] response in
                  guard let self else { return }

                  self.userBnadmates.append(contentsOf: response.data)
                  self.totalPages = response.pagination.totalPages
              }
              .store(in: &cancellables)
          }
      }

      // Refresh
    func refreshUserBandmates(userId:String) {
        fetchBandmates(userId: userId)
      }
    
    //Friend Requests
    func sendRequest(to userId: String) {
        isLoading = true
        errorMessage = nil
        successMessage = nil
        
        userService.sendRequest(reciverId: userId)
            .sink { [weak self] completion in
                self?.isLoading = false
                
                if case .failure(let error) = completion {
                    print("❌ Send Request Error:", error)
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] success in
                
                guard success else {
                    print("Failed to send request")
                    self?.errorMessage = "Failed to send request"
                    return
                }
                self?.successMessage = "Friend request sent ✅"
                self?.fetchUsers()
            }
            .store(in: &cancellables)
    }
    
    func acceptRequest(requestId: String) {
        isLoading = true
        errorMessage = nil
        
        userService.acceptFriendRequest(requestId: requestId)
            .sink { [weak self] completion in
                self?.isLoading = false
       
                if case .failure(let error) = completion {
                    print("Error: \(error)\n\(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] _ in
                self?.fetchUsers()
                self?.successMessage = "Friend request accepted"
            }
            .store(in: &cancellables)
    }
    
    func rejectRequest(requestId: String) {
         isLoading = true
         errorMessage = nil
         print(requestId)
         userService.rejectFriendRequest(requestId: requestId)
             .sink { [weak self] completion in
                 self?.isLoading = false
                 
                 if case .failure(let error) = completion {
                     print("Error: \(error)")
                     self?.errorMessage = error.localizedDescription
                 }
             } receiveValue: { [weak self] _ in
                 self?.fetchUsers()
                 self?.successMessage = "Friend request rejected"
             }
             .store(in: &cancellables)
     }
}
