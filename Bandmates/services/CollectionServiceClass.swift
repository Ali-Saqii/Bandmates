//
//  CollectionServiceClass.swift
//  Bandmates
//
//  Created by Mac mini on 21/04/2026.
//

import Foundation
import Combine
import UIKit

class CollectionClass {
    
    
    
    private let baseURL = "http://localhost:3000/user/get/collection"
   private let createUrl = "http://localhost:3000/user/create/collection"
    private let deleteCollectionURL = "http://localhost:3000/user/delete/collection"
    private let updateUrl = "http://localhost:3000/user/update/collection"
    private var authHeader: [String: String] {
           let token = UserDefaults.standard.string(forKey: "auth_token") ?? ""
           return ["Authorization": "Bearer \(token)"]
       }
       
        
        func getUserCollections(page: Int = 1) -> AnyPublisher<CollectionResponse, Error> {
            guard let token = UserDefaults.standard.string(forKey: "auth_token"),
                  let url = URL(string: "\(baseURL)?page=\(page)") else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw URLError(.badServerResponse)
                    }
                    switch httpResponse.statusCode {
                    case 200:
                        return data
                    case 401:
                        print(CollectionError.unauthorized)
                        throw CollectionError.unauthorized
                    case 404:
                        print(CollectionError.notFound)
                        throw CollectionError.notFound
                    case 500:
                        print(CollectionError.serverError)
                        throw CollectionError.serverError
                    default:
                        print(CollectionError.unknown)
                        throw CollectionError.unknown
                    }
                }
                .decode(type:CollectionResponse.self, decoder: decoder)
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    // create colletion
    
    func createCollection(name: String, description: String) -> AnyPublisher<ReviewResponse, Error> {
        guard let url = URL(string: "\(createUrl)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let body = CreateCollectionBody(name: name, description: description)
        
        return NetworkLayer.post(url: url, body: body, headers: authHeader)
            .decode(type: ReviewResponse.self, decoder: NetworkLayer.decoder)
            .eraseToAnyPublisher()
    }
    
    // delete collection
    
    func deleteCollection(id: String) -> AnyPublisher<ReviewResponse, Error> {
        guard let url = URL(string: "\(deleteCollectionURL)/\(id)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return NetworkLayer.delete(url: url, headers: authHeader)
            .decode(type: ReviewResponse.self, decoder: NetworkLayer.decoder)
            .eraseToAnyPublisher()
    }
    
    // UPDATE Collection
    func updateCollection(id: String, name: String, description: String) -> AnyPublisher<ReviewResponse, Error> {
        guard let url = URL(string: "\(updateUrl)/\(id)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let body = CreateCollectionBody(name: name, description: description)
        
        return NetworkLayer.put(url: url, body: body, headers: authHeader)
            .decode(type: ReviewResponse.self, decoder: NetworkLayer.decoder)
            .eraseToAnyPublisher()
    }
    
    // get maped array
    func getMappedCollections() -> AnyPublisher<[MapedCollection], Error> {
        getUserCollections()
            .map { response in
                response.data.map { MapedCollection(id: $0.id, title: $0.collectionTitle) }
            }
            .eraseToAnyPublisher()
    }
    
  



}

enum CollectionError: LocalizedError {
    case unauthorized
    case notFound
    case serverError
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .unauthorized: return "Session expired. Please login again."
        case .notFound:     return "No collections found."
        case .serverError:  return "Server error. Please try again later."
        case .unknown:      return "Something went wrong. Please try again."
        }
    }
}

struct MapedCollection: Identifiable {
    let id :String
    let title: String
}
