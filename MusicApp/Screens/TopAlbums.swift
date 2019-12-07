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
    @EnvironmentObject var viewModel: AppViewModel
    @Binding var presentation: PresentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                if (!self.viewModel.mostLovedAlbums.isEmpty) {
                    if (self.presentation == .List) {
                        AlbumList(albums: viewModel.mostLovedAlbums) { album in
                            AlbumDetails(album)
                        }
                    } else {
                        AlbumGrid(albums: viewModel.mostLovedAlbums) { album in
                            AlbumDetails(album)
                        }
                    }
                } else {
                    ActivityIndicator(.large)
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
        .onAppear(perform: {
            self.viewModel.loadMostLovedAlbums()
        })
    }
}

struct TopAlbums_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TopAlbums(presentation: .constant(.Grid))
            TopAlbums(presentation: .constant(.List))
        }
        .environmentObject(AppViewModel(mostLovedAlbums: previewMostLovedAlbums.loved))
    }
}
