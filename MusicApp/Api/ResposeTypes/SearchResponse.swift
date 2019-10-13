//
//  SearchResponse.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 12/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import SwiftUI

struct SearchResponse: Codable {
    let album: [Album]?
}
