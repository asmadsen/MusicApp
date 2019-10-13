//
//  AppViewModel.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 11/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import SwiftUI
import Combine

final class AppViewModel: ObservableObject {
    @Published var searchQuery = ""
    @Published private(set) var searchResult = [Album]()
    @Published private(set) var mostLovedAlbums =  [Album]()
    @Published private(set) var tracks = Dictionary<String, [Track]>()
    @Published private(set) var isLoadingTracks = false
    
    convenience init(mostLovedAlbums: [Album]) {
        self.init()
        self.mostLovedAlbums = mostLovedAlbums
    }
    
    convenience init(tracks: Dictionary<String, [Track]>) {
        self.init()
        self.tracks = tracks
    }
    
    convenience init(isLoadingTracks: Bool) {
        self.init()
        self.isLoadingTracks = isLoadingTracks
    }
    
    convenience init(searchResult: [Album]) {
        self.init()
        self.searchResult = searchResult
    }
    
    private var searchCancellable: AnyCancellable? {
        didSet { oldValue?.cancel() }
    }
    private var mostLovedCancellable: AnyCancellable? {
        didSet { oldValue?.cancel() }
    }
    private var tracksCancellable: AnyCancellable? {
        didSet { oldValue?.cancel() }
    }
    
    private(set) var searchQueryCancellable: AnyCancellable? {
        didSet { oldValue?.cancel() }
    }
    
    func loadMostLovedAlbums() {
        var request = URLRequest(url: URL(string: "https://theaudiodb.com/api/v1/json/1/mostloved.php?format=album")!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        mostLovedCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: MostLovedResponse.self, decoder: JSONDecoder())
            .map { $0.loved }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.mostLovedAlbums, on: self)
    }
    
    func loadTracks(_ albumId: String) {
        var urlComponents = URLComponents(string: "https://theaudiodb.com/api/v1/json/1/track.php")!
        urlComponents.queryItems = [
            URLQueryItem(name: "m", value: albumId)
        ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        self.isLoadingTracks = true
        tracksCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: TracksResponse.self, decoder: JSONDecoder())
            .map { $0.track }
            .mapError { error in
                error
            }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (result) in
                self.isLoadingTracks = false
            }, receiveValue: { (tracks) in
                self.tracks[albumId] = tracks
            })
    }
    
    func search() {
        guard !searchQuery.isEmpty else {
            return searchResult = []
        }

        var urlComponents = URLComponents(string: "https://theaudiodb.com/api/v1/json/1/searchalbum.php")!
        urlComponents.queryItems = [
            URLQueryItem(name: "s", value: searchQuery)
        ]

        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        searchCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: SearchResponse.self, decoder: JSONDecoder())
            .map { $0.album ?? [] }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.searchResult, on: self)
    }
    
    func startSearchListening() {
        searchQueryCancellable = $searchQuery
            .debounce(for: .milliseconds(250), scheduler: RunLoop.main)
            .sink { query in
                self.search()
        }
    }
    
    @Published private(set) var recommendedArtists = [SingleResult]()
    
    func loadRecommendedArtists(by tracks: [FavoriteTrack]) {
        let artistsSet = Set(tracks.map { $0.strArtist })
        
        
        guard !artistsSet.isEmpty else {
            return recommendedArtists = []
        }

        var urlComponents = URLComponents(string: "https://tastedive.com/api/similar")!
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: artistsSet.joined(separator: ",")),
            URLQueryItem(name: "k", value: "------API-TOKEN-------"),
        ]

        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        searchCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: TasteDiveResponse.self, decoder: JSONDecoder())
            .map { $0.Similar.Results }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.recommendedArtists, on: self)
    }
}
