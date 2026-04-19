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
    
    static let getUserProfileUrl = "http://localhost:3000/user/profile"
    static let deleteUserAccountUrl = "http://localhost:3000/user/delete"   // ✅ add your real endpoint

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
    
    // delete
    func deleteUser() -> AnyPublisher<String, Error> {
        guard let url = URL(string: UserClass.deleteUserAccountUrl) else {
            print("❌ Error: invalid URL")
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        let request = makeAuthRequest(url: url, method: "DELETE")

        return NetworkLayer.download(request: request)
            .decode(type: UserResponse.self, decoder: NetworkLayer.decoder)
            .handleEvents(receiveOutput: { [weak self] response in
                if response.sucess {
                    self?.user = nil
                    UserDefaults.standard.removeObject(forKey: "auth_token")
                    print("✅ Account deleted:", response.message)
                }
            })
            .map { $0.message }
            .eraseToAnyPublisher()
    }
    
    
}
