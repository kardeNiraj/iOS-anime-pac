//
//  LatestAnimeView.swift
//  hianime-clone
//
//  Created by apple on 14/08/24.
//

import SwiftUI

struct LatestAnimeView: View {
    var latestAnimes: [LatestEpisodeAnime]?
    
    var body: some View {
        if let latestAnimes = latestAnimes {
            ScrollViewReader { scrollViewProxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(0..<latestAnimes.count, id: \.self) { index in
                            LatestAnimeCard(anime: latestAnimes[index])
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
    LatestAnimeView(latestAnimes: [
        LatestEpisodeAnime(
            id: "gods-game-we-play-19110",
            name: "Gods' Game We Play",
            poster: "https://cdn.noitatnemucod.net/thumbnail/300x400/100/2e8eadbdb1bdda801ec2d8b4a5a8a9cc.jpg",
            duration: "23m",
            type: "TV",
            rating: nil,
            episodes: Episodes(
                sub: 5,
                dub: 5
            )
        ),
        LatestEpisodeAnime(
            id: "train-to-the-end-of-the-world-19106",
            name: "Train to the End of the World",
            poster: "https://cdn.noitatnemucod.net/thumbnail/300x400/100/c322c791493b191eb77e6a25df2fb000.jpg",
            duration: "23m",
            type: "TV",
            rating: nil,
            episodes: Episodes(
                sub: 5,
                dub: nil
            )
        ),
        LatestEpisodeAnime(
            id: "saint-seiya-knights-of-the-zodiac-battle-for-sanctuary-part-2-19090",
            name: "Saint Seiya: Knights of the Zodiac - Battle for Sanctuary Part 2",
            poster: "https://cdn.noitatnemucod.net/thumbnail/300x400/100/c65b7868c1ae4e97e08418876160a958.jpg",
            duration: "25m",
            type: "ONA",
            rating: nil,
            episodes: Episodes(
                sub: 7,
                dub: 6
            )
        ),
        LatestEpisodeAnime(
            id: "swallowed-star-2nd-season-18018",
            name: "Swallowed Star 2nd Season",
            poster: "https://cdn.noitatnemucod.net/thumbnail/300x400/100/23cc8e120b74d5fc55050b0e88f00758.jpg",
            duration: "21m",
            type: "ONA",
            rating: nil,
            episodes: Episodes(
                sub: 90,
                dub: nil
            )
        )
    ])
}
