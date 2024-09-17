//
//  EpisodesView.swift
//  hianime-clone
//
//  Created by apple on 29/08/24.
//

import SwiftUI

struct EpisodesView: View {
    @Binding var currentPlayingEpisode: Int
    var episodes: [EpisodeItem?]
    
    @State private var currentPage: Int = 1
    private let itemsPerPage: Int = 30
    var onEpisodeSelect: (Int) -> Void
    
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
                    let isCurrentlyPlaying: Bool = episode.number == currentPlayingEpisode
                    EpisodeBullet(episodeNumber: episode.number, isFiller: episode.isFiller, isCurrentlyPlaying: isCurrentlyPlaying)
                        .onTapGesture {
                            onEpisodeSelect(episode.number)
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
    EpisodesView(currentPlayingEpisode: .constant(1), episodes: [
        EpisodeItem(title: "one", episodeId: "one-1", number: 1, isFiller: false),
        EpisodeItem(title: "two", episodeId: "two-2", number: 2, isFiller: true),
        EpisodeItem(title: "three", episodeId: "three-3", number: 3, isFiller: false),
        EpisodeItem(title: "four", episodeId: "four-4", number: 4, isFiller: false),
        EpisodeItem(title: "five", episodeId: "five-5", number: 5, isFiller: false),
        EpisodeItem(title: "six", episodeId: "six-6", number: 6, isFiller: false),
        EpisodeItem(title: "seven", episodeId: "seven-7", number: 7, isFiller: true),
        EpisodeItem(title: "eight", episodeId: "eight-8", number: 8, isFiller: false),
        EpisodeItem(title: "nine", episodeId: "nine-9", number: 9, isFiller: false),
        EpisodeItem(title: "ten", episodeId: "ten-10", number: 10, isFiller: false),
        EpisodeItem(title: "eleven", episodeId: "eleven-11", number: 11, isFiller: false),
        EpisodeItem(title: "twelve", episodeId: "twelve-12", number: 12, isFiller: true),
        EpisodeItem(title: "thirteen", episodeId: "thirteen-13", number: 13, isFiller: false),
        EpisodeItem(title: "fourteen", episodeId: "fourteen-14", number: 14, isFiller: false),
        EpisodeItem(title: "fifteen", episodeId: "fifteen-15", number: 15, isFiller: false),
        EpisodeItem(title: "sixteen", episodeId: "sixteen-16", number: 16, isFiller: false),
        EpisodeItem(title: "seventeen", episodeId: "seventeen-17", number: 17, isFiller: true),
        EpisodeItem(title: "eighteen", episodeId: "eighteen-18", number: 18, isFiller: false),
        EpisodeItem(title: "nineteen", episodeId: "nineteen-19", number: 19, isFiller: false),
        EpisodeItem(title: "twenty", episodeId: "twenty-20", number: 20, isFiller: false),
        EpisodeItem(title: "twenty-one", episodeId: "twenty-one-21", number: 21, isFiller: false),
        EpisodeItem(title: "twenty-two", episodeId: "twenty-two-22", number: 22, isFiller: true),
        EpisodeItem(title: "twenty-three", episodeId: "twenty-three-23", number: 23, isFiller: false),
        EpisodeItem(title: "twenty-four", episodeId: "twenty-four-24", number: 24, isFiller: false),
        EpisodeItem(title: "twenty-five", episodeId: "twenty-five-25", number: 25, isFiller: false),
        EpisodeItem(title: "twenty-six", episodeId: "twenty-six-26", number: 26, isFiller: false),
        EpisodeItem(title: "twenty-seven", episodeId: "twenty-seven-27", number: 27, isFiller: true),
        EpisodeItem(title: "twenty-eight", episodeId: "twenty-eight-28", number: 28, isFiller: false),
        EpisodeItem(title: "twenty-nine", episodeId: "twenty-nine-29", number: 29, isFiller: false),
        EpisodeItem(title: "thirty", episodeId: "thirty-30", number: 30, isFiller: false),
        EpisodeItem(title: "thirty-one", episodeId: "thirty-one-31", number: 31, isFiller: false),
        EpisodeItem(title: "thirty-two", episodeId: "thirty-two-32", number: 32, isFiller: true),
        EpisodeItem(title: "thirty-three", episodeId: "thirty-three-33", number: 33, isFiller: false),
        EpisodeItem(title: "thirty-four", episodeId: "thirty-four-34", number: 34, isFiller: false),
        EpisodeItem(title: "thirty-five", episodeId: "thirty-five-35", number: 35, isFiller: false),
        EpisodeItem(title: "thirty-six", episodeId: "thirty-six-36", number: 36, isFiller: false),
        EpisodeItem(title: "thirty-seven", episodeId: "thirty-seven-37", number: 37, isFiller: true),
        EpisodeItem(title: "thirty-eight", episodeId: "thirty-eight-38", number: 38, isFiller: false),
        EpisodeItem(title: "thirty-nine", episodeId: "thirty-nine-39", number: 39, isFiller: false),
        EpisodeItem(title: "forty", episodeId: "forty-40", number: 40, isFiller: false),
        EpisodeItem(title: "forty-one", episodeId: "forty-one-41", number: 41, isFiller: false),
        EpisodeItem(title: "forty-two", episodeId: "forty-two-42", number: 42, isFiller: true),
        EpisodeItem(title: "forty-three", episodeId: "forty-three-43", number: 43, isFiller: false),
        EpisodeItem(title: "forty-four", episodeId: "forty-four-44", number: 44, isFiller: false),
        EpisodeItem(title: "forty-five", episodeId: "forty-five-45", number: 45, isFiller: false),
        EpisodeItem(title: "forty-six", episodeId: "forty-six-46", number: 46, isFiller: false),
        EpisodeItem(title: "forty-seven", episodeId: "forty-seven-47", number: 47, isFiller: true),
        EpisodeItem(title: "forty-eight", episodeId: "forty-eight-48", number: 48, isFiller: false),
        EpisodeItem(title: "forty-nine", episodeId: "forty-nine-49", number: 49, isFiller: false),
        EpisodeItem(title: "fifty", episodeId: "fifty-50", number: 50, isFiller: false),
        EpisodeItem(title: "fifty-one", episodeId: "fifty-one-51", number: 51, isFiller: false),
        EpisodeItem(title: "fifty-two", episodeId: "fifty-two-52", number: 52, isFiller: true),
        EpisodeItem(title: "fifty-three", episodeId: "fifty-three-53", number: 53, isFiller: false),
        EpisodeItem(title: "fifty-four", episodeId: "fifty-four-54", number: 54, isFiller: false),
        EpisodeItem(title: "fifty-five", episodeId: "fifty-five-55", number: 55, isFiller: false),
        EpisodeItem(title: "fifty-six", episodeId: "fifty-six-56", number: 56, isFiller: false),
        EpisodeItem(title: "fifty-seven", episodeId: "fifty-seven-57", number: 57, isFiller: true),
        EpisodeItem(title: "fifty-eight", episodeId: "fifty-eight-58", number: 58, isFiller: false),
        EpisodeItem(title: "fifty-nine", episodeId: "fifty-nine-59", number: 59, isFiller: false),
        EpisodeItem(title: "sixty", episodeId: "sixty-60", number: 60, isFiller: false)
    ]) { num in
        print(num)
    }
}
