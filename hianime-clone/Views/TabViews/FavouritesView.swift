//
//  ProfileView.swift
//  hianime-clone
//
//  Created by apple on 13/08/24.
//

import SwiftUI

struct FavouritesView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var favourites: [AnimeSummary] = []
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Text("Favourite Anime")
                    .font(.title2)
                
//                if favourites.isEmpty {
//                    Text("No Favourites Yet")
//                        .padding(.top, 26)
//                } else {
//                    LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
//                        ForEach(favourites, id: \.id) { anime in
//                            AnimeCardSmall(anime: anime)
//                        }
//                    }
//                }
                VStack {
                    Text("Feature under development")
                        .padding()
                        .font(.title3)
                        .foregroundStyle(.gray)
                    
                    Image(systemName: "fireworks")
                        .scaleEffect(5)
                        .frame(height: 100)
                        .foregroundStyle(.gray)
                    
                    Text("Will be there soon")
                        .padding()
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .padding(.horizontal)
            .padding(.top, 26)
            .onAppear {
                favourites = loadFavourites()
            }
        }
    }
}

#Preview {
    FavouritesView()
}
