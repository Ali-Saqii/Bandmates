//
//  saveAlbums.swift
//  Bandmates
//
//  Created by Mac mini on 16/04/2026.
//

import Foundation
import CoreData
import Combine

class savedAlbums {
    
    private let container : NSPersistentContainer
    private let containerName = "savedAlbums"
    private let entitiyName: String = "SavedAlbums"
    @Published var savedAlbums:[SavedAlbums] = []
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _ , error in
            if let error = error {
                print("error loading core date: \(error)")
            }
            self.getSavedAlbums()
        }
        self.getSavedAlbums()
    }
    func getSavedAlbums() {
        let request = NSFetchRequest<SavedAlbums>(entityName: entitiyName)
        do {
            savedAlbums = try container.viewContext.fetch(request)
        } catch let error {
            print("Error while fetching data:\(error)")

        }
    }
    func addAlbums(album:albumModel) {
        let entity = SavedAlbums(context: container.viewContext)
        entity.id = album.id
        entity.name = album.albumName
        entity.image = album.image
        entity.playLink = album.albumPlayLink
        savechanges()
    }
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("error while saving data: \(error)")
        }
    }
    private func savechanges() {
        save()
        getSavedAlbums()
    }
}
