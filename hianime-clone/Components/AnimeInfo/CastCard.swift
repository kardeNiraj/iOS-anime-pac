//
//  CastCard.swift
//  hianime-clone
//
//  Created by apple on 16/08/24.
//

import SwiftUI

struct CastCard: View {
    var actor: CharacterAndVoiceActor?
    
    var body: some View {
        if let actor = actor {
            VStack(alignment: .leading, spacing: 8) {
                RemoteImage(url: (actor.voiceActor?.poster!)!)
                    .aspectRatio(2/3, contentMode: .fill)
                    .frame(height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 2, y: 2)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Voice Actor")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text((actor.voiceActor?.name)!)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    
                    Text("Character")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text((actor.character?.name!)!)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                }
                .padding(.horizontal, 4)
            }
            .frame(width: 100)
            .padding(8)
            .background(Color(.systemBackground))
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
        }
    }
}

#Preview {
    CastCard(actor: CharacterAndVoiceActor(
        character: Actor(
            id: "luffy-monkey-d-3",
            poster: "https://cdn.noitatnemucod.net/thumbnail/100x100/100/5a4eaa036b66e63622272c1895bf3401.jpg",
            name: "Monkey D., Luffy",
            cast: "Main"
        ),
        voiceActor: Actor(
            id: "mayumi-tanaka-117",
            poster: "https://cdn.noitatnemucod.net/thumbnail/100x100/100/fdfe8d881f2f15c2e4bbe6c28ba1ab7f.jpg",
            name: "Tanaka, Mayumi",
            cast: "Japanese"
        )
    ))
}
