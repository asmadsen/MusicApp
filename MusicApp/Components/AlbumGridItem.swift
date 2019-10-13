//
//  AlbumGridItem.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 10/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import SwiftUI
import SwURL

struct AlbumGridItem: View {
    var album: Album
    var itemWidth: CGFloat
    
    init(_ album: Album, width: CGFloat = 150.0) {
        self.album = album
        self.itemWidth = width
    }
    
    var body: some View {
        VStack {
            URLImage(url: album.strAlbumThumb, placeholder: Image("albumcover-placeholder"))
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
            .clipped()
            .frame(width: self.itemWidth, height: self.itemWidth)
            Text(album.strAlbum)
                .font(.headline)
                .lineLimit(1)
            Text(album.strArtist)
                .font(.subheadline)
                .lineLimit(1)
        }
        .frame(width: self.itemWidth)
    }
}

struct AlbumGridItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AlbumGridItem(previewMostLovedAlbums.loved[0])
        }.previewLayout(.sizeThatFits)
    }
}
