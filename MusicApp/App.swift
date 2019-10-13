//
//  ContentView.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 10/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import SwiftUI
import Combine

struct App: View {
    @State private var selection = 1
    @State var presentation = PresentationMode.Grid
    @ObservedObject var viewModel: AppViewModel
    
    init(_ viewModel: AppViewModel = AppViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        TabView(selection: $selection) {
            TopAlbums(presentation: $presentation)
                .tabItem {
                    Image(systemName: "star")
                    Text("Top 50 Albums")
            }
            .tag(1)
            Search(presentation: $presentation)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
            }
            .tag(2)
            Favorites()
                .tabItem {
                    Image(systemName: "bookmark")
                    Text("Favorites")
            }
            .tag(3)
        }
            .environmentObject(viewModel)
    }
}

struct App_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            App(AppViewModel(mostLovedAlbums: previewMostLovedAlbums.loved))
            App(AppViewModel(mostLovedAlbums: previewMostLovedAlbums.loved))
            .environment(\.locale, Locale(identifier: "nb"))
        }
    }
}
