//
//  RemoteImage.swift
//  hianime-clone
//
//  Created by apple on 13/08/24.
//

import SwiftUI

struct RemoteImage: View {
    @StateObject private var imageLoader: ImageLoader
    var placeholder: Image
    
    init(url: String, placeholder: Image = Image(systemName: "photo")) {
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
        self.placeholder = placeholder
    }
    
    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else {
            placeholder
                .resizable()
                .scaledToFill()
        }
    }
}
