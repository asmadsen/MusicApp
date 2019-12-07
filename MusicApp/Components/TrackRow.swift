//
//  TrackRow.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 11/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import SwiftUI

struct TrackRow: View {
    var track: Track
    var isInFavorites: Bool
    var showArtist: Bool
    
    var duration: String {
        get {
            let interval = Int(track.intDuration)
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.minute, .second]
            formatter.unitsStyle = .positional
            
            let formattedString = formatter.string(from: TimeInterval(interval!/1000))!
            return formattedString
        }
    }
    
    init(_ track: Track, isInFavorites : Bool = false, showArtist: Bool = false) {
        self.track = track
        self.isInFavorites = isInFavorites
        self.showArtist = showArtist
    }
    
    var body: some View {
        HStack {
            Image(systemName: isInFavorites ? "star.fill" : "star")
                .foregroundColor(isInFavorites ? .yellow : .none)
                .padding()
            VStack(alignment: .leading) {
                Text(track.strTrack)
                    .font(.headline)
                    .lineLimit(1)
                if (self.showArtist) {
                    Text(track.strArtist)
                        .font(.subheadline)
                        .lineLimit(1)
                }
            }
            Spacer()
            Text(duration)
        }
    }
}

struct TrackRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TrackRow(previewTracks.track[0], isInFavorites: false)
            TrackRow(previewTracks.track[1], isInFavorites: true, showArtist: true)
        }
        .previewLayout(.fixed(width: 350.0, height: 50.0))
    }
}
