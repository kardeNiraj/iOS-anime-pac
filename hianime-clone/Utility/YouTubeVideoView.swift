//
//  YouTubeVideoView.swift
//  hianime-clone
//
//  Created by apple on 16/08/24.
//

import SwiftUI
import WebKit

struct YouTubeVideoView: View {
    let video: PromotionalVideo?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let video = video {
                LoadYTVideo(video: video)
                    .frame(height: 220)
                
                Text(video.title!)
                    .font(.headline)
            } else {
                Text("Video not available")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct LoadYTVideo: UIViewRepresentable {
    let video: PromotionalVideo?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let video = video, let url = URL(string: video.source!) else {
            return
        }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

#Preview {
    YouTubeVideoView(
        video: PromotionalVideo(
            title: "PV 3 Aniplex USA version",
            source: "https://www.youtube.com/embed/6vMuWuWlW4I",
            thumbnail: "https://i.ytimg.com/vi/6vMuWuWlW4I/hqdefault.jpg"
        )
    )
}
