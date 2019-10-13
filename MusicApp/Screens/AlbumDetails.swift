//
//  AlbumDetails.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 10/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import SwiftUI
import SwURL
import Combine

struct AlbumDetails: View {
    var album: Album
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: FavoriteTrack.getAllFavoriteTracks()) var favoriteTracks: FetchedResults<FavoriteTrack>
    
    var tracks: [Track] {
        viewModel.tracks[album.idAlbum] ?? []
    }
    
    init(_ album: Album) {
        self.album = album
    }
    
    var body: some View {
        List() {
            VStack(alignment: .leading) {
                URLImage(url: album.strAlbumThumb, placeholder: Image("albumcover-placeholder"))
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                HStack() {
                    Text(self.album.strAlbum)
                        .font(.title)
                    Spacer()
                    Text(self.album.intYearReleased)
                        .font(.callout)
                }
                .padding()
                Text(self.album.strArtist)
                    .font(.headline)
                    .padding()
                
            }
            .listRowInsets(EdgeInsets())
            Section(header: Text("Tracks")) {
                ForEach(tracks, id: \.idTrack) { track in
                    Button(action: { self.toggleAsFavorite(track) }) {
                        TrackRow(track, isInFavorites: self.trackIsFavorite(track))
                    }
                }
            }
        }
        .navigationBarTitle(Text(album.strAlbum), displayMode: .inline)
        .onAppear {
            self.viewModel.loadTracks(self.album.idAlbum)
        }
    }
    
    func toggleAsFavorite(_ track: Track) {
        let entry = favoriteTracks.first(where: { $0.idTrack == track.idTrack })
        if let entry = entry {
            self.managedObjectContext.delete(entry)
        } else {
            do {
                let item = FavoriteTrack(context: self.managedObjectContext)
                item.from(track: track)
                item.displayOrder = favoriteTracks.count
                try self.managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    func trackIsFavorite(_ track: Track) -> Bool {
        return favoriteTracks.contains(where: { $0.idTrack == track.idTrack })
    }
}

struct AlbumDetails_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AlbumDetails(previewMostLovedAlbums.loved[0])
            }
            .environmentObject(AppViewModel(tracks: [previewMostLovedAlbums.loved[0].idAlbum: previewTracks.track]))
            NavigationView {
                AlbumDetails(previewMostLovedAlbums.loved[0])
            }
            .environmentObject(AppViewModel(isLoadingTracks: true))
        }
        
    }
}
