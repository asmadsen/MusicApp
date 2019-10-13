//
//  ActivityIndicator.swift
//  MusicApp
//
//  Created by Andreas Storesund Madsen on 12/10/2019.
//  Copyright © 2019 Andreas Storesund Madsen. All rights reserved.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style
    @Binding var color: UIColor
    
    init(_ style: UIActivityIndicatorView.Style, color: Binding<UIColor> = .constant(UIColor.black)) {
        self.style = style
        self._color = color
    }

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.color = self.color
        uiView.startAnimating()
    }
}
struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActivityIndicator(.large)
            ActivityIndicator(.medium)
        }
        .previewLayout(.sizeThatFits)
    }
}
