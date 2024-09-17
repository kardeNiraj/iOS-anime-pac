//
//  RecommendedAnimeCard.swift
//  hianime-clone
//
//  Created by apple on 16/08/24.
//

import SwiftUI

struct RecommendedAnimeCard: View {
    var anime: AnimeSummary?
    
    var body: some View {
        if let anime = anime {
            NavigationLink(destination: AnimeInfoView(animeId: anime.id)) {
                VStack(alignment: .leading, spacing: 10) {
                    RemoteImage(url: anime.poster!)
                        .aspectRatio(16/9, contentMode: .fill)
                        .frame(width: 220, height: 112.5)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .black, radius: 5, x: 5, y: 5)
                    
                    Text("\(anime.name)")
                        .lineLimit(1)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    HStack {
                        CapsuleIconView(
                            icon: "tv",
                            count: anime.type!,
                            backgroundColor: .yellow
                        )
                        
                        Spacer()
                        CapsuleIconView(
                            icon: "clock",
                            count: anime.duration ?? "-",
                            backgroundColor: .orange
                        )
                        
                        Spacer()
                        CapsuleIconView(
                            icon: "captions.bubble.fill",
                            count: "\(anime.episodes?.sub ?? 0)",
                            backgroundColor: .green
                        )
                        Spacer()
                        CapsuleIconView(
                            icon: "mic.fill",
                            count: "\(anime.episodes?.dub ?? 0)",
                            backgroundColor: .blue
                        )
                    }
                }
                .frame(width: 220)
            }
        }
    }
}

#Preview {
    RecommendedAnimeCard(
        anime: AnimeSummary(
            id: "swallowed-star-2nd-season-18018",
            name: "Swallowed Star 2nd Season",
            poster: "https://cdn.noitatnemucod.net/thumbnail/300x400/100/23cc8e120b74d5fc55050b0e88f00758.jpg",
            duration: "21m",
            jname: nil,
            type: "ONA",
            rating: nil,
            episodes: Episodes(
                sub: 90,
                dub: nil
            )
        )
    )
}
