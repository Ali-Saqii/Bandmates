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
}
