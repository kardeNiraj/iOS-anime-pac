//
//  extensions.swift
//  hianime-clone
//
//  Created by apple on 13/08/24.
//

import SwiftUI

struct BackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Image("bg1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(.all)
                .blur(radius: 50.0)
            
            ScrollView {
                content
            }
            .scrollIndicators(.hidden)
            
        }
    }
}

extension View {
    func applyBackground() -> some View {
        self.modifier(BackgroundModifier())
    }
}
