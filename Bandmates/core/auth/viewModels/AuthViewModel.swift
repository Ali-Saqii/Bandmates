//
//  AuthViewModel.swift
//  Bandmates
//
//  Created by Mac mini on 13/04/2026.
//

import Foundation
import Combine
import UIKit

class AuthViewModel: ObservableObject {
    
    @Published var isLoading       = false
    @Published var isLoggedIn      = false
    @Published var isSignedUp    = false
    @Published var errorMessage    = ""
    @Published var fieldErrors:    [String: String] = [:]
    
    private var cancellables = Set<AnyCancellable>()
    
    func SignUp(userName:String,email:String,password:String,confirmPassword:String,avatar:UIImage? = nil,termsAndCondition:Bool) {
        guard termsAndCondition else {
            errorMessage = "you must agree to th terms and conditions"
            return
        }
        isLoading = true
        errorMessage = ""
        fieldErrors = [:]
        let avatarData = avatar?.jpegData(compressionQuality: 0.8)
        AuthService.shared.signUp(
            username: userName,
            email: email, password:password,
            confirmPassword: confirmPassword,
            avatar: avatarData
        )
        .sink { [weak self] completion in
            self?.isLoading = false
            if case .failure(let error) = completion {
                self?.errorMessage = error.localizedDescription
            }
        } receiveValue: { [weak self] response in
            DispatchQueue.main.async {
                if response.success {
                    if let token = response.token {
                        UserDefaults.standard.set(token, forKey: "auth_token")
                    }
                    self?.isSignedUp  = true
                } else {
                    self?.fieldErrors  = response.errors ?? [:]
                    self?.errorMessage = response.message ?? "Signup failed"
                }
            }
        }
        .store(in: &cancellables)
        
    }
    // login
    func Login(
        email:    String,
        password: String
    ) {
        guard !email.isEmpty else {
            fieldErrors["email"] = "Email is required"
            return
        }
        guard !password.isEmpty else {
            fieldErrors["password"] = "Password is required"
            return
        }
        
        isLoading    = true
        errorMessage = ""
        fieldErrors  = [:]
        
        AuthService.shared.login(
            email:    email,
            password: password
        )
        .sink { [weak self] completion in
            self?.isLoading = false
            if case .failure(let error) = completion {
                self?.errorMessage = error.localizedDescription
            }
        } receiveValue: { [weak self] response in
            DispatchQueue.main.async {
                if response.success {
                    if let token = response.token {
                        UserDefaults.standard.set(token, forKey: "auth_token")
                    }
                    self?.isLoggedIn = true
                } else {
                    self?.fieldErrors  = response.errors ?? [:]
                    self?.errorMessage = response.message ?? "Login failed"
                }
            }
        }
        .store(in: &cancellables)
    }
    func checkAuthStatus() {
        let token = UserDefaults.standard.string(forKey: "auth_token")
        
        if let token = token, !token.isEmpty {
            isLoggedIn    = true
        } else {
            isLoggedIn = false
        }
    }
    func signOut() {
        UserDefaults.standard.removeObject(forKey: "auth_token")
        DispatchQueue.main.async {
            self.isLoggedIn = false
            self.isSignedUp = false
            self.errorMessage = ""
            self.fieldErrors = [:]
        }
    }
}
