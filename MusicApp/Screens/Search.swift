//
//  Search.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 10/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import SwiftUI

struct Search: View {
    var albums: [Album]
    @Binding var presentation: PresentationMode
    @State var search = ""
    
    var body: some View {
        NavigationView {
        VStack(alignment: .leading) {
            TextField("Search", text: $search)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
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
        }
        .navigationBarTitle("Search")
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

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Group {
                Search(albums: previewMostLovedAlbums.loved, presentation: .constant(.Grid))
            
                Search(albums: previewMostLovedAlbums.loved, presentation: .constant(.List))
            
        }
    }
}
