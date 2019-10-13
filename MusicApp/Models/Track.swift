//
//  Track.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 11/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import SwiftUI

struct Track: Codable {
    let idTrack: String
    let idAlbum: String
    let idArtist: String
    let strTrack: String
    let strAlbum: String
    let strArtist: String
    let strArtistAlternate: String?
    let intDuration: String
}
