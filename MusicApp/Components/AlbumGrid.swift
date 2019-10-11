//
//  AlbumGrid.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 10/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import SwiftUI
import GridStack

struct AlbumGrid<Content: View>: View {
    var albums: [Album]
    var destination: (_ : Album) -> Content
    
    var body: some View {
        GridStack(minCellWidth: 150.0, spacing: 10, numItems: albums.count) { index, cellWidth in
            NavigationLink(destination: self.destination(self.albums[index])) {
                AlbumGridItem(self.albums[index], width: cellWidth)
                    .frame(width: cellWidth)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct AlbumGrid_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AlbumGrid(albums: previewMostLovedAlbums.loved) { album in
                    Text("Sub page: \(album.strAlbum)")
                }
            }
        }
    }
}
