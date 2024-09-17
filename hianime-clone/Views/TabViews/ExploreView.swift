//
//  ExploreView.swift
//  hianime-clone
//
//  Created by apple on 13/08/24.
//

import SwiftUI

struct ExploreView: View {
//    let genreList:
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        Text("hello moto")
//        LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
//            ForEach(favourites, id: \.id) { anime in
//                AnimeCardSmall(anime: anime)
//            }
//        }
    }
}

#Preview {
    ExploreView()
}
