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
    @Published var user             : userModel? = nil
     @Published var isLoading        : Bool       = false
     @Published var errorMessage     : String?    = nil
     @Published var successMessage   : String?    = nil
     @Published var isDeleted        : Bool       = false
     @Published var passwordSuccess  : Bool       = false
     @Published var passwordError    : String?    = nil
    @Published var isPrivate       : Bool    = false
    @Published var visibilityError : String? = nil
    
     private let userClass    = UserClass()
     private var cancellables = Set<AnyCancellable>()

    init() {
        fetchProfile()
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
    
    // MARK: - UPDATE User Profile
    @Published var isUpdated = false
    func updateProfile(
        username    : String? = nil,
        displayName : String? = nil,
        description : String? = nil,
        avatar      : UIImage?
    ) {
        isLoading       = true
        errorMessage    = nil
        successMessage  = nil

        userClass.updateUser(
            username    : username,
            displayName : displayName,
            description : description,
            avatar      : avatar
        )
        .sink(receiveCompletion: { [weak self] completion in
            self?.isLoading = false
            if case .failure(let error) = completion {
                print("Error: \(error)")
                self?.errorMessage = error.localizedDescription
            }
        }, receiveValue: { [weak self] success in
            if success {
                self?.successMessage = "Profile updated successfully"
                self?.isUpdated = true
                self?.fetchProfile()        // ✅ refresh user after update
            }
        })
        .store(in: &cancellables)
    }
    
    
    // update password
    
   
    
    func updatePassword(
        oldPassword     : String,
        newPassword     : String,
        confirmPassword : String
    ) {
        isLoading      = true
        passwordError  = nil
        passwordSuccess = false

        userClass.updatePassword(
            oldPassword     : oldPassword,
            newPassword     : newPassword,
            confirmPassword : confirmPassword
        )
        .sink(receiveCompletion: { [weak self] completion in
            self?.isLoading = false
            if case .failure(let error) = completion {
                print("Error: \(error)")
                self?.passwordError = error.localizedDescription
            }
        }, receiveValue: { [weak self] success in
            self?.isLoading     = false
            self?.passwordSuccess = success
            if success {
                self?.successMessage = "Password updated successfully"
            }
        })
        .store(in: &cancellables)
    }
        
    // delete user
    
    func deleteAccount() {
         isLoading    = true
         errorMessage = nil

         userClass.deleteUser()
             .sink(receiveCompletion: { [weak self] completion in
                 self?.isLoading = false
                 if case .failure(let error) = completion {
                     self?.errorMessage = error.localizedDescription
                 }
             }, receiveValue: { [weak self] success in
                 self?.isLoading  = false
                 self?.isDeleted  = success          // ✅ trigger navigation to login
                 if success {
                     UserDefaults.standard.removeObject(forKey: "auth_token")
                     self?.user = nil
                 }
             })
             .store(in: &cancellables)
     }
    // visibility
    func updateSavedAlbumsVisibility(isPrivate: Bool) {
        isLoading       = true
        errorMessage    = nil
        visibilityError = nil

        userClass.updateSavedAlbumsVisibility(isPrivate: isPrivate)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print("Error: \(error)")
                    self?.visibilityError = error.localizedDescription
                }
            }, receiveValue: { [weak self] success in
                self?.isLoading = false
                if success {
                    self?.isPrivate      = isPrivate
                    self?.successMessage = isPrivate ? "Albums set to private" : "Albums set to public"
                }
            })
            .store(in: &cancellables)
    }
}


