//
//  AlbumList.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 10/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import SwiftUI

struct AlbumList<Content : View>: View {
    var albums: [Album]
    var destination: (_ : Album) -> Content
    
    var body: some View {
        List(albums, id: \.idAlbum) { album in
            NavigationLink(destination: self.destination(album)) {
                AlbumListRow(album)
            }
        }
    }
}

struct AlbumList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AlbumList(albums: previewMostLovedAlbums.loved) { album in
                    Text("Sub page: \(album.strAlbum)")
                }
            }
        }
    }
}
