//
//  ContentView.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 10/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 1
    @State var presentation = PresentationMode.Grid
    
    
    var body: some View {
        
            TabView(selection: $selection) {
                TopAlbums(albums: previewMostLovedAlbums.loved, presentation: $presentation)
                    .tabItem {
                        Image(systemName: "star")
                        Text("Top 50 Albums")
                }
                .tag(1)
                Search(albums: previewMostLovedAlbums.loved, presentation: $presentation)
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
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .environment(\.locale, Locale(identifier: "nb"))
        }
    }
}
