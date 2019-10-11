//
//  TasteDiveResult.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 11/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import Foundation

struct SingleResult: Codable {
    let Name: String
}

struct Similar: Codable {
    let Results: [SingleResult]
    let Info: [SingleResult]
}

struct TasteDiveResponse: Codable {
    let Similar: Similar
}
