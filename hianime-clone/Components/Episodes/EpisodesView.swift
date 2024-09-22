//
//  EpisodesView.swift
//  hianime-clone
//
//  Created by apple on 29/08/24.
//

import SwiftUI

struct EpisodesView: View {
    @Binding var currentPlayingEpisode: EpisodeItem?
    var episodes: [EpisodeItem?]
    
    @State private var currentPage: Int = 1
    private let itemsPerPage: Int = 30
    var onEpisodeSelect: (EpisodeItem) -> Void
    
    private var totalPages: Int {
        let nonNilCount = episodes.compactMap { $0 }.count
        return (nonNilCount + itemsPerPage - 1) / itemsPerPage
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var paginatedEpisodes: [EpisodeItem] {
        let startIndex = (currentPage - 1) * itemsPerPage
        let endIndex = min(startIndex + itemsPerPage, episodes.compactMap { $0 }.count)
        return Array(episodes.compactMap { $0 }[startIndex..<endIndex])
    }
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                ForEach(paginatedEpisodes, id: \.episodeId) { episode in
                    let isCurrentlyPlaying: Bool = episode.episodeId == currentPlayingEpisode?.episodeId
                    EpisodeBullet(episodeNumber: episode.number, isFiller: episode.isFiller, isCurrentlyPlaying: isCurrentlyPlaying)
                        .onTapGesture {
                            onEpisodeSelect(episode)
                        }
                }
            }
            
            PaginationView(currentPage: $currentPage, totalPages: totalPages, itemsPerPage: itemsPerPage, totalItems: episodes.count, onPageChange: { newPage in
                currentPage = newPage
            })
        }
    }
}

#Preview {
    EpisodesView(currentPlayingEpisode: .constant(nil), episodes: [
        EpisodeItem(title: "one", episodeId: "one-1", number: 1, isFiller: false),
        EpisodeItem(title: "two", episodeId: "two-2", number: 2, isFiller: true),
        // Add more sample episodes here...
    ]) { episode in
        print(episode)
    }
}
