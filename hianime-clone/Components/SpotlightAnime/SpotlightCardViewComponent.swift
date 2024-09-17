//
//  CardViewComponent.swift
//  hianime-clone
//
//  Created by apple on 13/08/24.
//

import SwiftUI

struct SpotlightCardViewComponent: View {
    var anime: SpotlightAnime?
    
    var body: some View {
        NavigationLink(destination: AnimeInfoView(animeId: anime?.id)) {
            GeometryReader { geometry in
                if let anime = anime {
                    HStack {
                        ZStack(alignment: .bottomLeading) {
                            RemoteImage(url: anime.poster)
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(color: .black, radius: 5, x: 5, y: 5)
                            
                            ZStack {
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.black.opacity(0.8), Color.clear]),
                                    startPoint: .bottom,
                                    endPoint: .top
                                )
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Spacer()
                                    
                                    HStack(spacing: 16) {
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(anime.name)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .lineLimit(1)
                                                .shadow(radius: 3)
                                            
                                            Text(anime.description)
                                                .font(.subheadline)
                                                .foregroundColor(.white)
                                                .lineLimit(2)
                                                .shadow(radius: 3)
                                                .multilineTextAlignment(.leading)
                                        }
                                        .padding([.leading, .bottom], 5)
                                        
                                        HStack(spacing: 4) {
                                            CapsuleIconView(icon: "text.bubble.fill", count: "5", backgroundColor: Color.green)
                                            CapsuleIconView(icon: "mic.fill", count: "4", backgroundColor: Color.blue)
                                        }
                                        .padding([.trailing, .bottom], 5)
                                    }
                                    .padding([.leading, .bottom], 5)
                                }
                                .padding(.bottom, 5)
                            } // Add padding to the bottom of VStack to ensure it doesn't overlap with the overlay
                        }
                        .frame(width: geometry.size.width, height: 200)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .frame(height: 200)
        }
    }
}



struct CapsuleIconView: View {
    var icon: String
    var count: String
    var backgroundColor: Color
    
    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: icon)
                .font(.system(size: 12))
                .foregroundColor(.black)
            Text(count)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.black)
        }
        .padding(5)
        .background(backgroundColor)
        .cornerRadius(10)
        .fixedSize(horizontal: true, vertical: false)
    }
}

#Preview {
    SpotlightCardViewComponent(anime: SpotlightAnime(
        rank: 1,
        id: "the-duke-of-death-and-his-maid-season-3-19128",
        name: "The Duke of Death and His Maid Season 3",
        description: "The third season of Shinigami Bocchan to Kuro Maid.\n\nThe Duke and Alice will have their fates collide as their untouchable relationship comes to its conclusion!",
        poster: "https://cdn.noitatnemucod.net/thumbnail/1366x768/100/27756cc6545d8c73d47e31dd2315910e.jpg",
        jname: "Shinigami Bocchan to Kuro Maid 3rd Season",
        episodes: Episodes(sub: 6, dub: 3),
        otherInfo: [
            "TV",
            "23m",
            "Apr 7, 2024",
            "HD"
        ]   
    ))
}
