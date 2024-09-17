//
//  WatchAnimePageModels.swift
//  hianime-clone
//
//  Created by apple on 30/08/24.
//

import Foundation

struct EpisodesList: Codable {
    let totalEpisodes: Int
    let episodes: [EpisodeItem]
}

struct Servers: Decodable {
    let sub: [Server]?
    let dub: [Server]?
    let episodeId: String
    let episodeNo: Int
    
    private enum CodingKeys: String, CodingKey {
        case sub, dub, raw, episodeId, episodeNo
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.sub = try container.decodeIfPresent([Server].self, forKey: .sub)
        self.dub = try container.decodeIfPresent([Server].self, forKey: .dub)
        self.episodeId = try container.decodeIfPresent(String.self, forKey: .episodeId) ?? ""
        self.episodeNo = try container.decodeIfPresent(Int.self, forKey: .episodeNo) ?? 0
        _ = try container.decodeIfPresent([Server].self, forKey: .raw)
    }
}

struct Server: Codable, Hashable {
    let serverName: String?
    let serverId: Int?
}

struct StreamingLinks: Codable {
    let intro: Stamp?
    let outro: Stamp?
    let sources: [Source?]
    
    private enum CodingKeys: String, CodingKey {
        case intro, outro, sources, tracks, anilistID, malID
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.intro = try container.decodeIfPresent(Stamp.self, forKey: .intro)
        self.outro = try container.decodeIfPresent(Stamp.self, forKey: .outro)
        self.sources = try container.decodeIfPresent([Source].self, forKey: .sources) ?? []
        _ = try container.decodeIfPresent(Int.self, forKey: .anilistID)
        _ = try container.decodeIfPresent([Server].self, forKey: .tracks)
        _ = try container.decodeIfPresent(Int.self, forKey: .malID)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(intro, forKey: .intro)
        try container.encode(outro, forKey: .outro)
        try container.encode(sources, forKey: .sources)
        // try container.encodeIfPresent(tracks, forKey: .tracks)
        // try container.encodeIfPresent(anilistID, forKey: .anilistID)
        // try container.encodeIfPresent(malID, forKey: .malID)
    }
}

struct Track: Codable {
    let file: String?
    let kind: String?
}

struct Source: Codable {
    let url: String?
    let type: String?
}

struct Stamp: Codable {
    let start: Int?
    let end: Int?
}

struct AnyCodable: Codable {
    var value: Any

    init(_ value: Any) {
        self.value = value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let intValue = try? container.decode(Int.self) {
            value = intValue
        } else if let doubleValue = try? container.decode(Double.self) {
            value = doubleValue
        } else if let stringValue = try? container.decode(String.self) {
            value = stringValue
        } else if let boolValue = try? container.decode(Bool.self) {
            value = boolValue
        } else if let arrayValue = try? container.decode([AnyCodable].self) {
            value = arrayValue.map { $0.value }
        } else if let dictionaryValue = try? container.decode([String: AnyCodable].self) {
            value = dictionaryValue.mapValues { $0.value }
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unsupported type")
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        if let intValue = value as? Int {
            try container.encode(intValue)
        } else if let doubleValue = value as? Double {
            try container.encode(doubleValue)
        } else if let stringValue = value as? String {
            try container.encode(stringValue)
        } else if let boolValue = value as? Bool {
            try container.encode(boolValue)
        } else if let arrayValue = value as? [Any] {
            try container.encode(arrayValue.map { AnyCodable($0) })
        } else if let dictionaryValue = value as? [String: Any] {
            try container.encode(dictionaryValue.mapValues { AnyCodable($0) })
        } else {
            throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: encoder.codingPath, debugDescription: "Unsupported type"))
        }
    }
}
