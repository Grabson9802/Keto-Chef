//
//  ImageLoader.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?

    func loadImage(from url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .replaceError(with: Data())
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { data in
                self.image = UIImage(data: data)
            })
    }
}
