//
//  HomeView.swift
//  hianime-clone
//
//  Created by apple on 13/08/24.
//

import SwiftUI

struct HomeView: View {
    let homepageContent: HomePageContents = loadJSON("anime-home-page")
    
    var body: some View {
        VStack(alignment: .leading) {
            SpotlightCarouselView(spotlightAnimes: homepageContent.spotlightAnimes)
                .frame(height: 220)
            
            HStack {
                Image(systemName: "flame.fill")
                Text("Trending")
                    .font(.title2)
                    .padding(.vertical, 16)
            }
            
            TrendingAnimeView(trendingAnimes: homepageContent.trendingAnimes)
            
            HStack {
                Image("ghost")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("Latest Releases")
                    .font(.title2)
                    .padding(.vertical, 16)
            }
            
            LatestAnimeView(latestAnimes: homepageContent.latestEpisodeAnimes)
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.bottom, 26)
    }
}

#Preview {
    HomeView()
}
