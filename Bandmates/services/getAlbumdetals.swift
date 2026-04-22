//
//  getAlbumdetals.swift
//  Bandmates
//
//  Created by Mac mini on 16/04/2026.
//

import Foundation
import Combine
class AlbumDetailsService {
    
    private let baseURL = "http://localhost:3000/user/get/albums"
    private let reviewBaseURL = "http://localhost:3000/user/postReview" 
    private let commentBaseURL = "http://localhost:3000/user/postComment"
    // fetch album
    
    func fetchTrendingAlbums(token:String) -> AnyPublisher<[albumModel], Error> {
        guard let url = URL(string:baseURL) else {
            print ("bad url")
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
         
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
      
        return NetworkLayer.download(request: request)
            .decode(type: AlbumResponse.self, decoder: NetworkLayer.decoder)
            .map{$0.data}
            .eraseToAnyPublisher()
      
    }
    
    //post review
    
    // MARK: - POST Review
    func postReview(
        albumId    : String,
        rating     : Int,
        reviewText : String,
        token      : String
    ) -> AnyPublisher<Bool, Error> {

        guard let url = URL(string: "\(reviewBaseURL)/\(albumId)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        let body = ReviewBody(
            rating      : rating,
            review_text : reviewText
        )

        do {
            let request = try NetworkLayer.buildRequest(
                url     : url,
                method  : "POST",
                body    : body,
                headers : ["Authorization": "Bearer \(token)"]
            )

            return NetworkLayer.download(request: request)
                .decode(type: ReviewResponse.self, decoder: NetworkLayer.decoder)
                .handleEvents(receiveOutput: { response in
                    print(response.success ? "✅ Review posted: \(response.message)" : "❌ \(response.message)")
                })
                .map { $0.success }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
            //      post comment
  
    func postComment(
        albumId  : String,
        text     : String,
        parentId : String? = nil,   // ✅ optional — pass only for replies
        token    : String
    ) -> AnyPublisher<Bool, Error> {

        guard let url = URL(string: "\(commentBaseURL)/\(albumId)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        let body = CommentBody(
            text      : text,
            parent_id : parentId
        )

        do {
            let request = try NetworkLayer.buildRequest(
                url     : url,
                method  : "POST",
                body    : body,
                headers : ["Authorization": "Bearer \(token)"]
            )

            return NetworkLayer.download(request: request)
                .decode(type: ReviewResponse.self, decoder: NetworkLayer.decoder)  // ✅ reuse same response struct
                .handleEvents(receiveOutput: { response in
                    print(response.success ? "✅ Comment posted" : "❌ \(response.message)")
                })
                .map { $0.success }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    private let saveAlbumURL    = "http://localhost:3000/user/saveAlbum/add"
    private let removeAlbumURL  = "http://localhost:3000/user/savedAlbum/delete"

    // ── Save Album ─────────────────────────────────────────────────────────────────
    func saveAlbum(
        albumId      : String,
        collectionId : String,
        token        : String
    ) -> AnyPublisher<Bool, Error> {
        
        guard let url = URL(string: saveAlbumURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let body = SaveAlbumBody(album_id: albumId, collection_id: collectionId)
        
        do {
            let request = try NetworkLayer.buildRequest(
                url     : url,
                method  : "POST",
                body    : body,
                headers : ["Authorization": "Bearer \(token)"]
            )
            
            return NetworkLayer.download(request: request)
                .decode(type: ReviewResponse.self, decoder: NetworkLayer.decoder)
                .handleEvents(receiveOutput: { response in
                    print(response.success ? "✅ Album saved: \(response.message)" : "❌ \(response.message)")
                })
                .map { $0.success }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }

    // ── Remove Album ───────────────────────────────────────────────────────────────
    func removeAlbum(
        albumId      : String,
        collectionId : String,
        token        : String
    ) -> AnyPublisher<Bool, Error> {
        
        guard let url = URL(string: "\(removeAlbumURL)/\(albumId)/\(collectionId)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return NetworkLayer.download(request: request)
            .decode(type: ReviewResponse.self, decoder: NetworkLayer.decoder)
            .handleEvents(receiveOutput: { response in
                print(response.success ? "✅ Album removed: \(response.message)" : "❌ \(response.message)")
            })
            .map { $0.success }
            .eraseToAnyPublisher()
    }
}
// MARK: - Review Body
struct ReviewBody: Codable {
    let rating      : Int
    let review_text : String
}

// MARK: - Review Response
struct ReviewResponse: Codable {
    let success : Bool
    let message : String
}
struct CommentBody: Codable {
    let text      : String
    let parent_id : String?     // ✅ optional — nil for new comment, id for reply
}
struct SaveAlbumBody: Codable {
    let album_id      : String
    let collection_id : String
}
