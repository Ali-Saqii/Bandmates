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
  
}
