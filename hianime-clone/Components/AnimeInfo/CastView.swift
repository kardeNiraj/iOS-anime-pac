//
//  CastView.swift
//  hianime-clone
//
//  Created by apple on 16/08/24.
//

import SwiftUI

struct CastView: View {
    var cast: [CharacterAndVoiceActor?]
    var body: some View {
        if !cast.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(Array(cast.enumerated()), id: \.offset) { index, actor in
                        if let actor = actor {
                            CastCard(actor: actor)
                        }
                    }
                }
            }
        } else {
            Text("No data on cast")
                .font(.callout)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    CastView(cast: [
        CharacterAndVoiceActor(
            character: Actor(
                id: "brook-198",
                poster: "https://cdn.noitatnemucod.net/thumbnail/100x100/100/54cbbb789b82a8ca6f4b4b360ff5dfb6.jpg",
                name: "Brook",
                cast: "Main"
            ),
            voiceActor: Actor(
                id: "cho-471",
                poster: "https://cdn.noitatnemucod.net/thumbnail/100x100/100/1f315c80cb027f22256d54f5ace73f2d.jpg",
                name: "Cho",
                cast: "Japanese"
            )
        ),
        CharacterAndVoiceActor(
            character: Actor(
                id: "franky-307",
                poster: "https://cdn.noitatnemucod.net/thumbnail/100x100/100/a51f54aacfe2ac858c1e2870781449f0.jpg",
                name: "Franky",
                cast: "Main"
            ),
            voiceActor: Actor(
                id: "kazuki-yao-377",
                poster: "https://cdn.noitatnemucod.net/thumbnail/100x100/100/2a76c55a44f5f042779f9597e263f858.jpg",
                name: "Yao, Kazuki",
                cast: "Japanese"
            )
        ),
        CharacterAndVoiceActor(
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
        ),
        CharacterAndVoiceActor(
            character: Actor(
                id: "nami-102",
                poster: "https://cdn.noitatnemucod.net/thumbnail/100x100/100/a5a3e09b1ac8a8b479b71b4adeaae1c6.jpg",
                name: "Nami",
                cast: "Main"
            ),
            voiceActor: Actor(
                id: "akemi-okamura-453",
                poster: "https://cdn.noitatnemucod.net/thumbnail/100x100/100/56dc7d925d5e604fd2e4f5721a238221.jpg",
                name: "Okamura, Akemi",
                cast: "Japanese"
            )
        ),
    ])
}
