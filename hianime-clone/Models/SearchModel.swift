//
//  SearchModel.swift
//  hianime-clone
//
//  Created by apple on 20/08/24.
//

import Foundation

struct SearchResult: Decodable {
    let animes: [AnimeSummary]?
    let mostPopularAnimes: [AnimeSummary]?
    let currentPage: Int?
    let hasNextPage: Bool?
    let totalPages: Int?
    let searchQuery: String?
    let searchFilters: Filters?
}


struct Filters: Decodable {
    let sort: String?
    let status: String?
    let rated: String?
    let genres: String?
    let type: String?
    let score: String?
    let language: String?
    let season: String?
}

struct SearchSuggestions: Decodable {
    let suggestions: [SearchSuggestion]?
}

struct SearchSuggestion: Identifiable, Decodable {
    let id: String
    let name: String
    let jname: String?
    let poster: String
    let moreInfo: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, name, jname, poster, moreInfo
    }
}
