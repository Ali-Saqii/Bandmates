//
//  collectionModel.swift
//  Bandmates
//
//  Created by Mac mini on 16/04/2026.
//

import Foundation
import Combine

class collectionViewModel:ObservableObject {
    
    @Published var collections:[CollectionModel]? = nil
}
