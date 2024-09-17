//
//  TrendingAnimeCard.swift
//  hianime-clone
//
//  Created by apple on 14/08/24.
//

import SwiftUI

struct TrendingAnimeCard: View {
    var anime: TrendingAnime?
    
    var body: some View {
        NavigationLink(destination: AnimeInfoView(animeId: anime?.id)) {
            ZStack(alignment: .topLeading) {
                if let anime = anime {
                    RemoteImage(url: anime.poster)
                        .scaledToFill()
                        .frame(width: 180, height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .black, radius: 5, x: 5, y: 5)
                    
                    Text("\(anime.rank)")
                        .font(.system(size: 14, weight: .black))
                        .foregroundColor(.white)
                        .padding(7)
                        .background(Color.red)
                        .cornerRadius(5)
                }
            }
        }
    }
}

#Preview {
    TrendingAnimeCard(anime: TrendingAnime(
        rank: 1,
        id: "one-piece-100", name: "One Piece",
        poster: "https://cdn.noitatnemucod.net/thumbnail/300x400/100/bcd84731a3eda4f4a306250769675065.jpg"
    ))
}
