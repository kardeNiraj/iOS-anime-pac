//
//  RatingView.swift
//  hianime-clone
//
//  Created by apple on 14/08/24.
//

import SwiftUI

struct StarRatingView: View {
    var rating: String
    var ratingScale: Double = 10 // Default to 10 but can be adjusted
    var maxRating: Int = 5
    var starSize: CGFloat = 16
    var filledColor: Color = .yellow
    var emptyColor: Color = .gray
    
    private func normalizedRating() -> Double {
        guard let ratingValue = Double(rating) else {
            return 0
        }
        return min(max(ratingValue * Double(maxRating) / ratingScale, 0), Double(maxRating))
    }
    
    private func starType(for index: Int) -> Double {
        let adjustedRating = normalizedRating()
        return min(max(adjustedRating - Double(index), 0), 1)
    }
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<maxRating, id: \.self) { index in
                ZStack {
                    Image(systemName: "star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: starSize, height: starSize)
                        .foregroundColor(emptyColor)
                    
                    if starType(for: index) > 0 {
                        Image(systemName: starType(for: index) >= 1 ? "star.fill" : "star.leadinghalf.filled")
                            .resizable()
                            .scaledToFit()
                            .frame(width: starSize, height: starSize)
                            .foregroundColor(filledColor)
                            .mask(
                                GeometryReader { geometry in
                                    Rectangle()
                                        .size(width: geometry.size.width * starType(for: index), height: geometry.size.height)
                                }
                            )
                    }
                }
            }
        }
    }
}

#Preview {
    VStack {
        StarRatingView(rating: "8.6", ratingScale: 10)
        StarRatingView(rating: "5.0", ratingScale: 10)
        StarRatingView(rating: "4.3", ratingScale: 10)
        StarRatingView(rating: "20.0", ratingScale: 20) // Example with a scale of 20
        StarRatingView(rating: "invalid") // Example with invalid rating
    }
    .padding()
}
