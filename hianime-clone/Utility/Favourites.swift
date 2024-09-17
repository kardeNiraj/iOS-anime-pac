//
//  Favourites.swift
//  hianime-clone
//
//  Created by apple on 21/08/24.
//

import Foundation

func saveFavourites(_ favourites: [AnimeSummary]) {
    if let encoded = try? JSONEncoder().encode(favourites) {
        UserDefaults.standard.set(encoded, forKey: "favourite_animes")
    }
}

func loadFavourites() -> [AnimeSummary] {
    if let savedData = UserDefaults.standard.data(forKey: "favourite_animes"),
       let decoded = try? JSONDecoder().decode([AnimeSummary].self, from: savedData) {
        return decoded
    }
    return []
}
