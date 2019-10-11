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
    let idLyric: String
    let idIMVDB: String?
    let strTrack: String
    let strAlbum: String
    let strArtist: String
    let strArtistAlternate: String?
    let intCD: String?
    let intDuration: String
    let strGenre: String
    let strMood: String?
    let strStyle: String?
    let strTheme: String?
    let strDescriptionEN: String?
    let strTrackThumb: String?
    let strTrack3DCase: String?
    let strTrackLyrics: String?
    let strMusicVid: String?
    let strMusicVidDirector: String?
    let strMusicVidCompany: String?
    let strMusicVidScreen1: String?
    let strMusicVidScreen2: String?
    let strMusicVidScreen3: String?
    let intMusicVidViews: String?
    let intMusicVidLikes: String?
    let intMusicVidDislikes: String?
    let intMusicVidFavorites: String?
    let intMusicVidComments: String?
    let intTrackNumber: String
    let intLoved: String
    let intScore: String
    let intScoreVotes: String
    let intTotalListeners: String?
    let intTotalPlays: String?
    let strMusicBrainzID: String
    let strMusicBrainzAlbumID: String
    let strMusicBrainzArtistID: String
    let strLocked: String
}
