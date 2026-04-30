//
//  ChartViewModel.swift
//  Bandmates
//
//  Created by Mac mini on 27/04/2026.
//

import Foundation
import Combine

class chartViewModel: ObservableObject {
    
    @Published var chart: [AlbumRatingModel]? = nil
    @Published var isLoading = false
    @Published var message = ""
    
    private var Service = chartService()
    private var cancellables = Set<AnyCancellable>()
    init() {
        getChartData()
    }
    
    // Get char data
     func getChartData() {
        isLoading = true
        message = ""
        Service.fetchAlbumRatings()
            .sink { [weak self ] completion in
                guard let self = self else {return}
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.message = error.localizedDescription
                    if let decodingError = error as? DecodingError {
                        switch decodingError {
                        case .keyNotFound(let key, let context):
                            print("❌ Key not found:", key, context.debugDescription)
                        case .typeMismatch(let type, let context):
                            print("❌ Type mismatch:", type, context.debugDescription)
                        case .valueNotFound(let type, let context):
                            print("❌ Value not found:", type, context.debugDescription)
                        case .dataCorrupted(let context):
                            print("❌ Data corrupted:", context.debugDescription)
                        @unknown default:
                            print("❌ Unknown decoding error:", error)
                        }
                    } else {
                        print("❌ Network or other error:", error)
                    }
                }
            } receiveValue: {  [weak self ] chartAlbum in
                self?.chart = chartAlbum.data
                print("chart Albums loaded:")
            }
            .store(in: &cancellables)
    }
    
}
