//
//  Search.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 10/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import SwiftUI

struct Search: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Binding var presentation: PresentationMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                TextField("Search", text: $viewModel.searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                ZStack {
                    if (self.presentation == .List) {
                        AlbumList(albums: viewModel.searchResult) { album in
                            AlbumDetails(album)
                        }
                    } else {
                        AlbumGrid(albums: viewModel.searchResult) { album in
                            AlbumDetails(album)
                        }
                    }
                }
            }
            .onAppear(perform: {
                self.viewModel.startSearchListening()
            })
            .onDisappear(perform: {
                self.viewModel.searchQueryCancellable?.cancel()
            })
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
            Search(presentation: .constant(.Grid))
            
            Search(presentation: .constant(.List))
        }
        .environmentObject(AppViewModel(searchResult: previewMostLovedAlbums.loved))
    }
}
