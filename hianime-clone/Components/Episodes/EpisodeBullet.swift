//
//  EpisodeBullet.swift
//  hianime-clone
//
//  Created by apple on 29/08/24.
//

import SwiftUI

struct EpisodeBullet: View {
    var episodeNumber: Int
    var isFiller: Bool
    var isCurrentlyPlaying: Bool
    
    var body: some View {
        let episodeString = String(episodeNumber)
        
        Text(episodeString)
            .frame(maxWidth: .infinity)
            .font(.body)
            .padding(8)
            .background(isCurrentlyPlaying ? Color.red : isFiller ? Color.orange.opacity(0.5) : Color.gray.opacity(0.5))
            .cornerRadius(8)
    }
}

#Preview {
    EpisodeBullet(episodeNumber: 1012, isFiller: false, isCurrentlyPlaying: true)
}
