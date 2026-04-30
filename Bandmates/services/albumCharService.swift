//
//  albumCharService.swift
//  Bandmates
//
//  Created by Mac mini on 27/04/2026.
//

import Foundation
import Combine

class chartService {
    
    private let getChartURl = "http://localhost:3000/user/get/chart"

    private var cancellables = Set<AnyCancellable>()

    var token: String {
        UserDefaults.standard.string(forKey: "auth_token") ?? ""
    }
    func fetchAlbumRatings() -> AnyPublisher<AlbumRatingsResponse, Error> {
        guard let url = URL(string: getChartURl) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return NetworkLayer.download(request: request)
            .handleEvents(receiveOutput: { data in
                })
            .decode(type: AlbumRatingsResponse.self,
                     decoder: NetworkLayer.decoder)
            .handleEvents(receiveOutput: { response in
                          
                       })
            .eraseToAnyPublisher()
    }
}
