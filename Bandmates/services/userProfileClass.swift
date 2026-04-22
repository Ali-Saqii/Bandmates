//
//  userProfileClass.swift
//  Bandmates
//
//  Created by Mac mini on 19/04/2026.
//

import Foundation
import Combine
import UIKit

class UserClass {
    
    @Published var user: userModel? = nil
    static let updateVisibilityUrl = "http://localhost:3000/user/hideCollection"
    static let getUserProfileUrl = "http://localhost:3000/user/profile"
    static let deleteUserAccountUrl = "http://localhost:3000/user/delete"
    static let updateUserUrl = "http://localhost:3000/user/update"
    static let updatePassword = "http://localhost:3000/user/changePassword"
    private var token: String {
         UserDefaults.standard.string(forKey: "auth_token") ?? ""
     }
    private var cancellables = Set<AnyCancellable>()
    
    // make a request
    private func makeAuthRequest(url: URL,method:String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    
    func getUser() -> AnyPublisher<userModel, Error> {
        guard let url = URL(string: UserClass.getUserProfileUrl) else {
            print("Error: in valid url")
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()

        }
        
        let request = makeAuthRequest(url: url, method: "GET")
        
        return NetworkLayer.download(request: request)
            .decode(type: UserResponse.self, decoder: NetworkLayer.decoder)
            .handleEvents(receiveOutput: { [weak self] response in
                      self?.user = response.data?.toUserModel()    //
                  })
                  .compactMap { $0.data?.toUserModel() }
                  .eraseToAnyPublisher()
    }
    // update user
    func updateUser(
        username    : String? = nil,
        displayName : String? = nil,
        description : String? = nil,
        avatar      : UIImage?,
        email       : String? = nil
    ) -> AnyPublisher<Bool, Error> {
        guard let url = URL(string: UserClass.updateUserUrl) else {
            print("Invalid url")
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        let avatarData = avatar?.jpegData(compressionQuality: 0.8)
        let body = UpdateUserBody(
            username    : username,
            displayName : displayName,
            description : description,
            avatar      : avatarData,
            email: email
        )

        do {
            let request = try NetworkLayer.buildRequest(url: url, method: "PUT", body: body, headers: ["Authorization": "Bearer \(token)"] )
            return NetworkLayer.download(request: request)
                .decode(type: UserResponse.self, decoder: NetworkLayer.decoder)
                .handleEvents(receiveOutput: { [weak self] response in
                    self?.user = response.data?.toUserModel()
                })
                .map { $0.success }
                .eraseToAnyPublisher()
        } catch {
            print("Error: \(error.localizedDescription)")
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    // update password
    func updatePassword(
        oldPassword     : String,
        newPassword     : String,
        confirmPassword : String
    ) -> AnyPublisher<Bool, Error> {

        guard let url = URL(string: UserClass.updatePassword) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        // MARK: - Client Side Validation
        guard !oldPassword.isEmpty else {
            return Fail(error: NSError(domain: "", code: 0,
                userInfo: [NSLocalizedDescriptionKey: "Old password cannot be empty"]))
                .eraseToAnyPublisher()
        }

        guard newPassword.count >= 8 else {
            return Fail(error: NSError(domain: "", code: 0,
                userInfo: [NSLocalizedDescriptionKey: "Password must be at least 8 characters"]))
                .eraseToAnyPublisher()
        }

        guard newPassword == confirmPassword else {
            return Fail(error: NSError(domain: "", code: 0,
                userInfo: [NSLocalizedDescriptionKey: "Passwords do not match"]))
                .eraseToAnyPublisher()
        }

        guard newPassword != oldPassword else {
            return Fail(error: NSError(domain: "", code: 0,
                userInfo: [NSLocalizedDescriptionKey: "New password must be different from old password"]))
                .eraseToAnyPublisher()
        }

        let body = UpdatePasswordBody(
            oldPassword     : oldPassword,
            newPassword     : newPassword,
            confirmPassword : confirmPassword
        )

        do {
            let request = try NetworkLayer.buildRequest(
                url     : url,
                method  : "PUT",
                body    : body,
                headers : ["Authorization": "Bearer \(token)"]
            )

            return NetworkLayer.download(request: request)
                .tryMap { data -> Data in
                        print("📦 Raw:", String(data: data, encoding: .utf8) ?? "nil")
                        return data
                    }
                .decode(type: UserResponse.self, decoder: NetworkLayer.decoder)
                .handleEvents(receiveOutput: { response in
                    print(response.success ? "✅ Password updated" : "❌ \(response.message)")
                    print(response.message)
                })
                .map { $0.success }
                .eraseToAnyPublisher()
        } catch {
            print("Error\(error.localizedDescription)")

            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    // delete
    func deleteUser() -> AnyPublisher<Bool, Error> {
        guard let url = URL(string: UserClass.deleteUserAccountUrl) else {
            print("❌ Error: invalid URL")
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        let request = makeAuthRequest(url: url, method: "DELETE")

        return NetworkLayer.download(request: request)
            .decode(type: UserResponse.self, decoder: NetworkLayer.decoder)
            .handleEvents(receiveOutput: { [weak self] response in
                if response.success {
                    self?.user = nil
                    UserDefaults.standard.removeObject(forKey: "auth_token")
                    print("✅ Account deleted:", response.message)
                }
            })
            .map { $0.success }
            .eraseToAnyPublisher()
    }
    
    // collection visibility
    func updateSavedAlbumsVisibility(isPrivate: Bool) -> AnyPublisher<Bool, Error> {
        guard let url = URL(string: UserClass.updateVisibilityUrl) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        do {
            let request = try NetworkLayer.buildRequest(
                url     : url,
                method  : "PUT",
                body    : ["isPrivate": isPrivate],     // ✅ inline dictionary, no separate struct
                headers : ["Authorization": "Bearer \(token)"]
            )

            return NetworkLayer.download(request: request)
                .decode(type: UserResponse.self, decoder: NetworkLayer.decoder)
                .handleEvents(receiveOutput: { response in
                    print(response.success ? "✅ Visibility updated: \(isPrivate)" : "❌ \(response.message)")
                })
                .map { $0.success }
                .eraseToAnyPublisher()
        } catch {
            print("Error\(error.localizedDescription)")
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}


struct UpdateUserBody: Codable {
    var username    : String?
    var displayName : String?
    var description : String?
    var avatar      : Data? 
    var email       : String?
}
struct UpdatePasswordBody: Codable {
    let oldPassword     : String
    let newPassword     : String
    let confirmPassword : String
}
