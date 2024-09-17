import Foundation

// Main struct to decode the entire JSON
struct AnimeInfo: Codable {
    let anime: AnimeDetail
    let seasons: [Season]
    let mostPopularAnimes: [AnimeSummary]
    let relatedAnimes: [AnimeSummary]
    let recommendedAnimes: [AnimeSummary]
}

// AnimeDetail struct to include info and moreInfo
struct AnimeDetail: Codable {
    let info: Anime
    let moreInfo: MoreInfo
}

// Anime struct updated to match the JSON structure for 'info'
struct Anime: Codable {
    let id: String?
    let anilistId: Int?
    let malId: Int?
    let name: String?
    let poster: String?
    let description: String?
    let stats: AnimeStats?
    let promotionalVideos: [PromotionalVideo?]
    let charactersVoiceActors: [CharacterAndVoiceActor?]
    
    enum CodingKeys: String, CodingKey {
        case id, anilistId, malId, name, poster, description, stats, promotionalVideos, charactersVoiceActors
    }
}

// MoreInfo struct to represent additional details
struct MoreInfo: Codable {
    let japanese: String?
    let synonyms: String?
    let aired: String?
    let premiered: String?
    let duration: String?
    let status: String?
    let malscore: String?
    let genres: [String?]
    let studios: String?
    let producers: [String?]
    
    enum CodingKeys: String, CodingKey {
        case japanese, synonyms, aired, premiered, duration, status, malscore, genres, studios, producers
    }
}

// Other structs remain the same
struct AnimeStats: Codable {
    let rating: String?
    let quality: String?
    let episodes: Episodes?
    let type: String?
    let duration: String?
}

struct CharacterAndVoiceActor: Codable {
    let character: Actor?
    let voiceActor: Actor?
}

struct Actor: Codable {
    let id: String?
    let poster: String?
    let name: String?
    let cast: String?
}

struct PromotionalVideo: Codable, Identifiable {
    var id: String?
    let title: String?
    let source: String?
    let thumbnail: String?
}

struct Season: Codable {
    let id: String?
    let name: String?
    let title: String?
    let poster: String?
    let isCurrent: Bool?
}

struct AnimeSummary: Codable {
    let id: String?
    let name: String?
    let poster: String?
    let duration: String?
    let jname: String?
    let type: String?
    let rating: String?
    let episodes: Episodes?
}
