//
//  EpisodeItem.swift
//  hianime-clone
//
//  Created by apple on 29/08/24.
//

import Foundation

struct EpisodeData: Codable {
    let totalEpisodes: Int
    let episodes: [EpisodeItem]
}

struct EpisodeItem: Codable {
    let title: String
    let episodeId: String
    let number: Int
    let isFiller: Bool
}
