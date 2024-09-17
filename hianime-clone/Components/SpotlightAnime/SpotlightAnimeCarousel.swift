//
//  SpotlightAnimeCarousel.swift
//  hianime-clone
//
//  Created by apple on 14/08/24.
//

import SwiftUI

struct SpotlightCarouselView: View {
    let spotlightAnimes: [SpotlightAnime]
    @State private var currentIndex: Int = 0
    @State private var timer: Timer? = nil
    
    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { scrollViewProxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 16) {
                        ForEach(0..<spotlightAnimes.count * 2, id: \.self) { index in
                            SpotlightCardViewComponent(anime: spotlightAnimes[index % spotlightAnimes.count])
                                .frame(width: geometry.size.width)
                                .padding(.vertical)
                                .id(index)
                        }
                    }
                    .padding(.horizontal, 16)
                    .onAppear {
                        startTimer(proxy: scrollViewProxy, geometry: geometry)
                    }
                    .onDisappear {
                        stopTimer()
                    }
                }
            }
        }
        .frame(height: 220)
    }
    
    private func startTimer(proxy: ScrollViewProxy, geometry: GeometryProxy) {
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            withAnimation {
                currentIndex += 1
                proxy.scrollTo(currentIndex % (spotlightAnimes.count * 2), anchor: .center)
            }
            
            if currentIndex == spotlightAnimes.count * 2 {
                currentIndex = 0
                proxy.scrollTo(currentIndex, anchor: .center)
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
