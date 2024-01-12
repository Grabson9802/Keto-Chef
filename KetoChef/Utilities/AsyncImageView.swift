//
//  AsyncImageView.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

import SwiftUI

struct AsyncImageView: View {
    @StateObject private var imageLoader = ImageLoader()
    private var url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    var body: some View {
        Image(uiImage: (imageLoader.image ?? UIImage(named: "steak"))!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onAppear {
                imageLoader.loadImage(from: url)
            }
    }
}
