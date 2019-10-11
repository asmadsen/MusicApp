//
//  AlbumDetails.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 10/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import SwiftUI
import URLImage

struct AlbumDetails: View {
    var album: Album
    
    init(_ album: Album) {
        self.album = album
    }
    
    var body: some View {
        List() {
            VStack(alignment: .leading) {
                URLImage(URL(string: self.album.strAlbumThumb)!, placeholder: Image("albumcover-placeholder")) { proxy in
                    proxy.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                }
                .frame(maxWidth: .infinity)
                HStack() {
                    Text(self.album.strAlbum)
                        .font(.title)
                    Spacer()
                    Text(self.album.intYearReleased)
                        .font(.callout)
                }
                .padding()
                Text(self.album.strArtist)
                    .font(.headline)
                    .padding()
                
            }
                .listRowInsets(EdgeInsets())
            Section(header: Text("Tracks")) {
                ForEach(previewTracks.track, id: \.idTrack) { track in
                    TrackRow(track, isInFavorites: false)
                }
            }
        }
        .navigationBarTitle(Text(album.strAlbum), displayMode: .inline)
    }
}

struct AlbumDetails_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AlbumDetails(previewMostLovedAlbums.loved[0])
            }
        }
    }
}
