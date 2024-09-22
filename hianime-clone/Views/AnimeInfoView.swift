//
//  AnimeInfoView.swift
//  hianime-clone
//
//  Created by apple on 15/08/24.
//

import SwiftUI

struct AnimeInfoView: View {
    @State private var animeInfo: AnimeInfo? = loadJSON("anime-about-info")
//    @State private var animeInfo: AnimeInfo?
    var animeId: String?
    
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if isLoading {
                    ProgressView()
                        .padding()
                } else if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else if let animeInfo = animeInfo {
                    HStack(spacing: 12) {
                        RemoteImage(url: animeInfo.anime.info.poster ?? "")
                            .frame(width: 180, height: 240)
                            .cornerRadius(10)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text(animeInfo.anime.info.name!)
                                .font(.title)
                                .lineLimit(1)
                            Text(animeInfo.anime.info.description!)
                                .lineLimit(4)
                                .font(.subheadline)
                            
                            VStack(alignment: .leading) {
                                Text("Japanese: \(animeInfo.anime.moreInfo.japanese ?? "NA")")
                                Text("Aired on: \(animeInfo.anime.moreInfo.aired ?? "NA")")
                                Text("Status: \(animeInfo.anime.moreInfo.status ?? "NA")")
                            }
                            .font(.caption)
                            
                            StarRatingView(rating: animeInfo.anime.moreInfo.malscore!, ratingScale: 10)
                            
                            // buttons
                            HStack {
                                if let id = animeInfo.anime.info.id {
                                    Button {
                                        //
                                    } label: {
                                        NavigationLink(destination: WatchEpisodeView(animeName: animeInfo.anime.info.name ?? "NA", animeId: id)) {
                                            Text("Watch Now")
                                        }
                                    }.buttonStyle(RoundedButtonStyle(buttonType: .primary))
                                }
                                
                                Button {
                                    //
                                } label: {
                                    HStack {
                                        Text("Details")
                                    }
                                }.buttonStyle(RoundedButtonStyle(buttonType: .secondary))
                            }
                        }
                    }
                    
                    Divider()
                        .background(.gray)
                        .padding()
                    
                    Text("Videos")
                        .font(.title2)
                        .padding(.vertical, 16)
                    
                    if animeInfo.anime.info.promotionalVideos.count > 0 {
                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(animeInfo.anime.info.promotionalVideos, id: \.?.id) { video in
                                YouTubeVideoView(video: video)
                            }
                        }
                    } else {
                        Text("No videos available")
                            .font(.callout)
                            .foregroundStyle(.gray)
                    }
                    
                    // cast
                    Text("Cast")
                        .font(.title2)
                        .padding(.vertical, 16)
                    CastView(cast: animeInfo.anime.info.charactersVoiceActors)
                    
                    // related anime
                    Text("Related")
                        .font(.title2)
                        .padding(.vertical, 16)
                    AnimeListView(animeList: animeInfo.recommendedAnimes)
                    
                    // recommended anime
                    Text("You Might Like")
                        .font(.title2)
                        .padding(.vertical, 16)
                    AnimeListView(animeList: animeInfo.relatedAnimes)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 26)
        }
        .onAppear {
            getAnimeDetails()
        }
        .scrollIndicators(.hidden)
    }
    
    func getAnimeDetails() {
        guard let animeId = animeId else {
            errorMessage = "Invalid anime ID"
            return
        }

        isLoading = true
        
        APIClient.shared.makeRequest(endpoint: "\(Endpoints.ANIME_DETAILS)?id=\(animeId)") { (result: Result<AnimeInfo, Error>) in
            
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let responseData):
                    print("successfully fetched anime details:\n \(responseData)")
                    self.animeInfo = responseData
                case .failure(let error):
                    print("error while fetching anime details:\n \(error)")
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

#Preview {
    AnimeInfoView(animeId: "one-piece-100")
}

