//
//  ImageLoader.swift
//  hianime-clone
//
//  Created by apple on 13/08/24.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil
    
    private var cache = CacheManager()
    private var cancellable: AnyCancellable?
    private let url: String
    
    init(url: String) {
        self.url = url
        loadImage()
    }
    
    private func loadImage() {
        if let cachedData = CacheManager.getImageCache(url), let cachedImage = UIImage(data: cachedData) {
            self.image = cachedImage
            return
        }
        
        guard let imageURL = URL(string: url) else {
            return
        }
        
        let session = URLSession.shared
        cancellable = session.dataTaskPublisher(for: imageURL)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] downloadedImage in
                guard let self = self, let downloadedImage = downloadedImage, let data = downloadedImage.pngData() else { return }
                CacheManager.setImageCache(self.url, image: data)
                self.image = downloadedImage
            }
    }
}

