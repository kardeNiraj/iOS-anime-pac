//
//  IIFE.swift
//  hianime-clone
//
//  Created by apple on 21/08/24.
//

import SwiftUI

func insertFavourites() {
    let hasInsertedFavouritesKey = "hasInsertedFavourites"

    // Check if the data has already been inserted
    if UserDefaults.standard.bool(forKey: hasInsertedFavouritesKey) {
        return
    }

    // Define the array of AnimeSummary objects
    let favourites: [AnimeSummary] = [
        AnimeSummary(
            id: "gods-game-we-play-19110",
            name: "Gods' Game We Play",
            poster: "https://cdn.noitatnemucod.net/thumbnail/300x400/100/2e8eadbdb1bdda801ec2d8b4a5a8a9cc.jpg",
            duration: "23m",
            jname: nil,
            type: "TV",
            rating: nil,
            episodes: Episodes(sub: 5, dub: 5)
        ),
        AnimeSummary(
            id: "train-to-the-end-of-the-world-19106",
            name: "Train to the End of the World",
            poster: "https://cdn.noitatnemucod.net/thumbnail/300x400/100/c322c791493b191eb77e6a25df2fb000.jpg",
            duration: "23m",
            jname: nil,
            type: "TV",
            rating: nil,
            episodes: Episodes(sub: 5, dub: nil)
        ),
        AnimeSummary(
            id: "saint-seiya-knights-of-the-zodiac-battle-for-sanctuary-part-2-19090",
            name: "Saint Seiya: Knights of the Zodiac - Battle for Sanctuary Part 2",
            poster: "https://cdn.noitatnemucod.net/thumbnail/300x400/100/c65b7868c1ae4e97e08418876160a958.jpg",
            duration: "25m",
            jname: nil,
            type: "ONA",
            rating: nil,
            episodes: Episodes(sub: 7, dub: 6)
        )
    ]

    // Encode and save to UserDefaults
    if let encoded = try? JSONEncoder().encode(favourites) {
        UserDefaults.standard.set(encoded, forKey: "favourite_animes")
        UserDefaults.standard.set(true, forKey: hasInsertedFavouritesKey)
    }
}

