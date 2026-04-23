//
//  SavedAlbumClass.swift
//  Bandmates
//
//  Created by Mac mini on 23/04/2026.
//

import Foundation
import Combine

class SaveAlbumService {
    
    
    private let baseURL = "http://localhost:3000/user"

    func fetchSavedAlbums(userId: String,
                          token: String,
                          page: Int,
                          limit: Int) -> AnyPublisher<AlbumResponse, Error> {

        guard let url = URL(string:
            "\(baseURL)/user/savedAlbums/\(userId)?page=\(page)&limit=\(limit)"
        ) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // 🔐 Auth Header
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        return NetworkLayer.download(request: request)
            .decode(type: AlbumResponse.self, decoder: NetworkLayer.decoder)
            .eraseToAnyPublisher()
    }
}
