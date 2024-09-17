//
//  AnimeModel.swift
//  hianime-clone
//
//  Created by apple on 13/08/24.
//

import Foundation

struct HomePageContents: Codable {
    let spotlightAnimes: [SpotlightAnime]
    let trendingAnimes: [TrendingAnime]
    let latestEpisodeAnimes: [LatestEpisodeAnime]
    let topUpcomingAnimes: [TopUpcomingAnime]
    let top10Animes: Top10Animes
    let topAiringAnimes: [TopAiringAnime]
    let genres: [String]
}

struct SpotlightAnime: Codable {
    let rank: Int
    let id: String
    let name: String
    let description: String
    let poster: String
    let jname: String
    let episodes: Episodes
    let otherInfo: [String]
}

struct TrendingAnime: Codable {
    let rank: Int
    let id: String
    let name: String
    let poster: String
}

struct LatestEpisodeAnime: Codable {
    let id: String
    let name: String
    let poster: String
    let duration: String
    let type: String
    let rating: String?
    let episodes: Episodes
}

struct TopUpcomingAnime: Codable {
    let id: String
    let name: String
    let poster: String
    let duration: String
    let type: String
    let rating: String?
    let episodes: Episodes
}

struct Top10Animes: Codable {
    let today: [TopAnime]
    let week: [TopAnime]
    let month: [TopAnime]
}

struct TopAnime: Codable {
    let id: String
    let rank: Int
    let name: String
    let poster: String
    let episodes: Episodes
}

struct TopAiringAnime: Codable {
    let id: String
    let name: String
    let jname: String
    let poster: String
    let otherInfo: [String]
}

struct Episodes: Codable {
    let sub: Int?
    let dub: Int?
}
