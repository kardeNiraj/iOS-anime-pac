//
//  TrendingAnimeView.swift
//  hianime-clone
//
//  Created by apple on 14/08/24.
//

import SwiftUI

struct TrendingAnimeView: View {
    var trendingAnimes: [TrendingAnime]?
    
    var body: some View {
        if let trendingAnimes = trendingAnimes {
            ScrollViewReader { scrollViewProxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 16) {
                        ForEach(0..<trendingAnimes.count, id: \.self) { index in
                            TrendingAnimeCard(anime: trendingAnimes[index])
                                .frame(width: 180, height: 240)
//                                .padding(.vertical)
                                .id(index)
                        }
                    }
                }
            }
        } else {
            Text("No trending animes available.")
                .foregroundColor(.gray)
                .padding()
        }
    }
}

#Preview {
    TrendingAnimeView(
        trendingAnimes: [
            TrendingAnime(
                rank: 1,
                id: "one-piece-100",
                name: "One Piece",
                poster: "https://cdn.noitatnemucod.net/thumbnail/300x400/100/bcd84731a3eda4f4a306250769675065.jpg"
            ),
            TrendingAnime(
                rank: 2,
                id: "kaiju-no-8-19145",
                name: "Kaiju No. 8",
                poster: "https://cdn.noitatnemucod.net/thumbnail/300x400/100/edfc7fe935b6eac2d704cf5b0a60e356.jpg"
            ),
            TrendingAnime(
                rank: 3,
                id: "my-hero-academia-season-7-19146",
                name: "My Hero Academia Season 7",
                poster: "https://cdn.noitatnemucod.net/thumbnail/300x400/100/af4938d7388aad3438e443e74b02531e.jpg"
            )
        ]
    )
}
