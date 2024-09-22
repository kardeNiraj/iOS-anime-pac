//
//  PopularAnimeCard.swift
//  hianime-clone
//
//  Created by apple on 20/08/24.
//

import SwiftUI

struct AnimeCardSmall: View {
    var anime: AnimeSummary?
    
    var body: some View {
        if let anime = anime {
            NavigationLink(destination: AnimeInfoView(animeId: anime.id)) {
                VStack(alignment: .leading, spacing: 8) {
                    ZStack(alignment: .topTrailing) {
                        
                        RemoteImage(url: anime.poster!)
                            .aspectRatio(2/3, contentMode: .fill)
                            .frame(height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .frame(alignment: .top)
                        .shadow(color: .black.opacity(0.2), radius: 4, x: 2, y: 2)

//                        Image(systemName: "heart.fill")
//                            .font(.system(size: 16))
//                            .foregroundStyle(.red)
//                            .padding([.top, .trailing], 5)
                    }
                    
                    Text(anime.name ?? "")
                        .font(.footnote)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                .frame(width: 100, alignment: .top)
                .padding(8)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
            }
        }
    }
}

#Preview {
    AnimeCardSmall(anime: AnimeSummary(
        id: "is-it-wrong-to-try-to-pick-up-girls-in-a-dungeon-arrow-of-the-orion-1693",
        name: "Is It Wrong to Try to Pick Up Girls in a Dungeon?: Arrow of the Orion",
        poster: "https://cdn.noitatnemucod.net/thumbnail/300x400/100/35356c13f5a026be1c0612ee546b2078.jpg",
        duration: "82m", jname: nil,
        type: "Movie",
        rating: nil,
        episodes: Episodes(
            sub: 1,
            dub: 1
        )
        
    ))
}

