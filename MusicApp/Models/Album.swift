//
//  Album.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 10/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import SwiftUI

struct Album: Codable {
    let idAlbum: String
    let idArtist: String
    let idLabel: String?
    let strAlbum: String
    let strAlbumStripped: String
    let strArtist: String
    let strArtistStripped: String
    let intYearReleased: String
    let strAlbumThumb: String?
    let strAlbumThumbHQ: String?
    let strAlbumThumbBack: String?
    let strAlbumCDart: String?
    let strAlbumSpine: String?
    let strAlbum3DCase: String?
    let strAlbum3DFlat: String?
    let strAlbum3DFace: String?
    let strAlbum3DThumb: String?
}
