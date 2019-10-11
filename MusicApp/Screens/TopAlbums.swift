//
//  TopAlbums.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 10/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import SwiftUI

enum PresentationMode{
    case Grid
    case List
}

struct TopAlbums: View {
    var albums: [Album]
    @Binding var presentation: PresentationMode
    
    var body: some View {
        NavigationView {
        ZStack {
            if (self.presentation == .Grid) {
                AlbumList(albums: albums) { album in
                    AlbumDetails(album)
                }
            } else {
                AlbumGrid(albums: albums) { album in
                    AlbumDetails(album)
                }
            }
        }
        .navigationBarTitle("Albums")
        .navigationBarItems(trailing: Picker("Display mode", selection: self.$presentation) {
            Image(systemName: "square.grid.3x2")
                .tag(PresentationMode.Grid)
            Image(systemName: "text.justify")
                .tag(PresentationMode.List)
        }
        .pickerStyle(SegmentedPickerStyle()))
        }
        
    }
}

struct TopAlbums_Previews: PreviewProvider {
    static var previews: some View {
        Group {
                TopAlbums(albums: previewMostLovedAlbums.loved, presentation: .constant(.Grid))
            
            
                TopAlbums(albums: previewMostLovedAlbums.loved, presentation: .constant(.List))
            
        }
    }
}
