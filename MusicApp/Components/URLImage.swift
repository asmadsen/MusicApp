//
//  URLImage.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 12/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import SwiftUI
import SwURL

struct URLImage: View {
    var url: String?
    var placeholder: Image
    
    private var _url: URL? {
        guard let url = self.url else { return nil }
        return URL(string: url)
    }
    
    
    var body: some View {
        ZStack {
            if (_url != nil) {
                RemoteImageView(
                    url: self._url!,
                    placeholderImage: self.placeholder,
                    transition: .custom(
                        transition: .opacity,
                        animation: .easeOut(duration: 0.5)
                    )
                )
            } else {
                self.placeholder
                    .resizable()
            }
        }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(url: previewMostLovedAlbums.loved[0].strAlbumThumb, placeholder: Image("albumcover-placeholder"))
    }
}
