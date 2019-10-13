//
//  Favorites.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 11/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import SwiftUI

struct Favorites: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: FavoriteTrack.getAllFavoriteTracks()) var favoriteTracks: FetchedResults<FavoriteTrack>
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List{
                    ForEach(favoriteTracks, id: \.idTrack) { track in
                        TrackRow(track.toTrack(), isInFavorites: true, showArtist: true)
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
                        ForEach(viewModel.recommendedArtists, id: \.Name) { artist in
                            Text(artist.Name)
                                .padding()
                                .background(Color.blue)
                        }
                    }
                }
                .onAppear(perform: {
                    self.viewModel.loadRecommendedArtists(by: Array(self.favoriteTracks))
                })
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationBarTitle("Favorites")
            
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        guard let sourcePos: Int = source.first else { return }
        let lower = min(sourcePos, destination)
        let higher = max(sourcePos, destination)
        var tmpArray = Array(self.favoriteTracks)
        let subject = tmpArray[sourcePos]

        tmpArray.insert(subject, at: destination)
        if (destination < sourcePos) {
            tmpArray.remove(at: sourcePos + 1)
        } else {
            tmpArray.remove(at: sourcePos)
        }
        tmpArray.enumerated().forEach({ offset, element in
            guard lower <= offset || offset >= higher else {
                return
            }
            element.displayOrder = offset
        })
        managedObjectContext.perform {
            do {
                try self.managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    func delete(at indicies: IndexSet) {
        indicies.forEach { index in
            managedObjectContext.delete(favoriteTracks[index])
        }
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Favorites()
            
        }
    }
}
