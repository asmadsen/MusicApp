//
//  FavoriteTrack.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 12/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import Foundation
import CoreData

public class FavoriteTrack: NSManagedObject {
    @NSManaged public var createdAt: Date?
    @NSManaged public var idTrack: String
    @NSManaged public var idAlbum: String
    @NSManaged public var idArtist: String
    @NSManaged public var strTrack: String
    @NSManaged public var strAlbum: String
    @NSManaged public var strArtist: String
    @NSManaged public var strArtistAlternate: String?
    @NSManaged public var intDuration: String
    @NSManaged public var displayOrder: Int
}

extension FavoriteTrack {
    static func getAllFavoriteTracks() -> NSFetchRequest<FavoriteTrack> {
        let request = FavoriteTrack.fetchRequest() as! NSFetchRequest<FavoriteTrack>
        
        let sortDescriptor = NSSortDescriptor(key: "displayOrder", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
    
    static func getBy(idTrack: String) -> NSFetchRequest<FavoriteTrack> {
        let request = FavoriteTrack.fetchRequest() as! NSFetchRequest<FavoriteTrack>
        
        request.predicate = NSPredicate(format: "idTrack = %@", idTrack)
        
        return request
    }
    
    func from(track: Track) {
        self.createdAt = Date()
        self.idTrack = track.idTrack
        self.idAlbum = track.idAlbum
        self.idArtist = track.idArtist
        self.strTrack = track.strTrack
        self.strAlbum = track.strAlbum
        self.strArtist = track.strArtist
        self.strArtistAlternate = track.strArtistAlternate
        self.intDuration = track.intDuration
    }
    
    func toTrack() -> Track {
        return Track(
            idTrack: idTrack, idAlbum: idAlbum, idArtist: idArtist, strTrack: strTrack, strAlbum: strAlbum, strArtist: strArtist, strArtistAlternate: strArtistAlternate, intDuration: intDuration
        )
    }
}
