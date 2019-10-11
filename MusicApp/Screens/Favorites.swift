//
//  Favorites.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 11/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import SwiftUI

struct Favorites: View {
    @State var tracks = previewTracks.track
    
    var body: some View {
        NavigationView {
        VStack(alignment: .leading) {
            List{
                ForEach(tracks, id: \.idTrack) { track in
                    TrackRow(track, isInFavorites: true, showArtist: true)
                }
                .onMove(perform: move)
                .onDelete(perform: delete)
            
            }
            .navigationBarItems(trailing: EditButton())
            Text("Recommended Artists")
                .font(.title)
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 10.0) {
                    ForEach(previewTaseDive.Similar.Results, id: \.Name) { artist in
                        Text(artist.Name)
                            .padding()
                            .background(Color.blue)
                    }
                }
            }
                .padding(.horizontal)
                .padding(.bottom)
        }
        .navigationBarTitle("Favorites")
        
        }
    }
    
    func delete(at index: IndexSet) {
        tracks.remove(atOffsets: index)
    }
    
    func move(from: IndexSet, to: Int) {
        tracks.move(fromOffsets: from, toOffset: to)
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Favorites()
        
        }
    }
}
