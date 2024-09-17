//
//  RecommendedAnimeView.swift
//  hianime-clone
//
//  Created by apple on 16/08/24.
//

import SwiftUI

struct AnimeListView: View {
    var animeList: [AnimeSummary]?
    
    var body: some View {
        if let animeList = animeList {
            ScrollViewReader { scrollViewProxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(0..<animeList.count, id: \.self) { index in
                            RecommendedAnimeCard(anime: animeList[index])
                                .frame(width: 220)
                                .id(index)
                        }
                    }
                }
            }
        } else {
            Text("No latest animes available.")
                .foregroundColor(.gray)
                .padding()
        }
        
    }
}

#Preview {
    AnimeListView(
        animeList: [
            AnimeSummary(
                id: "beelzebub-624",
                name: "Beelzebub",
                poster: "https://cdn.noitatnemucod.net/thumbnail/300x400/100/fd0489c24f51d5b2d6632bd4f10f4621.jpg",
                duration: "24m",
                jname: nil,
                type: "TV",
                rating: nil,
                episodes: Episodes(
                    sub: 5,
                    dub: 5
                )
            ),
            AnimeSummary(
                id: "hidamari-sketch-x-627",
                name: "Hidamari Sketch x ☆☆☆",
                poster: "https://cdn.noitatnemucod.net/thumbnail/300x400/100/b566b16ca34d10844500b6c835b607a6.jpg",
                duration: "24m",
                jname: nil,
                type: "TV",
                rating: nil,
                episodes: Episodes(
                    sub: 5,
                    dub: nil
                )
            ),
            AnimeSummary(
                id: "high-score-girl-628",
                name: "High Score Girl",
                poster: "https://cdn.noitatnemucod.net/thumbnail/300x400/100/d747aae80886f53ce0ae712d8db56d8c.jpg",
                duration: "24m",
                jname: nil,
                type: "TV",
                rating: nil,
                episodes: Episodes(
                    sub: 7,
                    dub: 6
                )
            ),
            AnimeSummary(
                id: "lupin-the-third-630",
                name: "Lupin the Third",
                poster: "https://cdn.noitatnemucod.net/thumbnail/300x400/100/d253ed16235c10f371abb14f4cce028f.jpg",
                duration: "25m",
                jname: nil,
                type: "TV",
                rating: nil,
                episodes: Episodes(
                    sub: 90,
                    dub: nil
                )
            )
        ]
    )
}
