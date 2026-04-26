//
//  BandmateServiceClass.swift
//  Bandmates
//
//  Created by Mac mini on 23/04/2026.
//

import Foundation
import Combine
import UIKit

class BandmateClass {
    private let baseURL = "http://localhost:3000/user"
    
    private var token: String {
        UserDefaults.standard.string(forKey: "auth_token") ?? ""
    }
    
    func fetchUsers(page: Int, limit: Int) -> AnyPublisher<BandmateResponse, Error> {

        guard var components = URLComponents(string: "\(baseURL)/getUsers") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "limit", value: "\(limit)")
        ]

        guard let url = components.url else {
        
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // 🔐 ADD TOKEN HERE
        let token = UserDefaults.standard.string(forKey: "auth_token") ?? ""

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        return NetworkLayer.download(request: request)
            .decode(type: BandmateResponse.self, decoder: NetworkLayer.decoder)
            .eraseToAnyPublisher()
    }
    
    // user's bandmates
    func fetchBandmates(
        userId: String,
        page: Int,
        limit: Int
    ) -> AnyPublisher<BandmateResponse, Error> {

        guard let url = URL(string:
            "\(baseURL)/getUser/friends/\(userId)?page=\(page)&limit=\(limit)"
        ) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        return NetworkLayer.download(request: request)
            .decode(type: BandmateResponse.self, decoder: NetworkLayer.decoder)
            .eraseToAnyPublisher()
    }
    
    // send request
    
    func sendRequest(reciverId: String) -> AnyPublisher<Bool, Error> {
        
        guard let url = URL(string: "\(baseURL)/friends/request") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return NetworkLayer.post(
            url: url,
            body: requestBody(receiver_id: reciverId),
            headers: ["Authorization": "Bearer \(token)"]
        )
        .decode(type: friendRequestResponse.self, decoder: NetworkLayer.decoder)
        .map{$0.success}
        .eraseToAnyPublisher()
    }
    
    // Accept Request
    func acceptFriendRequest(
        requestId: String,
    ) -> AnyPublisher<Bool, Error> {
        
        guard let url = URL(string: "\(baseURL)/friends/accept/\(requestId)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        
        return NetworkLayer.patch(
            url: url,
            headers: ["Authorization": "Bearer \(token)"]
        )
        .map { _ in true }
        .eraseToAnyPublisher()
    }
    
    // Reject Request
    func rejectFriendRequest(
        requestId: String,
    ) -> AnyPublisher<Bool, Error> {
        
        guard let url = URL(string: "\(baseURL)/friends/reject/\(requestId)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return NetworkLayer.patch(
            url: url,
            headers: ["Authorization": "Bearer \(token)"]
        )
        .map { _ in true }
        .eraseToAnyPublisher()
    }
}

struct requestBody: Codable {
    let receiver_id: String
}

struct friendRequestResponse: Codable {
    let success: Bool
    let message: String
}
