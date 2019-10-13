//
//  AlbumListRow.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 10/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import SwiftUI
import SwURL

struct AlbumListRow: View {
    var album: Album
    
    init (_ album: Album) {
        self.album = album
    }
    
    var body: some View {
        HStack {
            URLImage(url: album.strAlbumThumb, placeholder: Image("albumcover-placeholder"))
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
            .clipped()
            .frame(width: 75.0, height: 75.0)
            VStack(alignment: .leading) {
                Text(album.strAlbum)
                    .font(.headline)
                Text(album.strArtist)
                    .font(.subheadline)
            }
            Spacer()
        }
    }
}

struct AlbumListRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AlbumListRow(previewMostLovedAlbums.loved[0])
        }.previewLayout(.sizeThatFits)
    }
}
