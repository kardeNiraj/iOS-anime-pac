//
//  APIEndpoints.swift
//  hianime-clone
//
//  Created by apple on 22/08/24.
//

import SwiftUI

struct Endpoints {
    static let BASE_URL = "https://hianime.p.rapidapi.com/"
    
    static let HOME_PAGE = "anime/home"
    
    static let SEARCH_ANIME_BY_ID = "anime/search" // query: q=girls & page=1 & type=movie & status=finished-airing & rated=pg-13 & score=good & season=spring & language=dub & sort=score & genres=action%2Cadventure
    
    static let SEARCH_ANIME_SUGGESTION = "anime/search/suggest" // query: q=monster
    
    static let SEARCH_ANIME_BY_GENRE = "anime/genre" // genre should be queried as: anime/genre/shounen?page=1
    
    static let ANIME_DETAILS = "anime/info" // query: id=one-piece-100
    
    static let EPISODE_SERVERS = "anime/servers" // query: episodeId=one-piece-100&ep=122
    
    static let STREAMING_LINKS = "anime/episode-srcs" //query id=steinsgate-3%3Fep 230 & server=vidstreaming & category=dub
    
    static let LIST_EPISODES = "anime/episodes" // params: /one-piece-100
}
