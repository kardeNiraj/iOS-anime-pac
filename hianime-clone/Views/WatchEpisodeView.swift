//
//  WatchEpisodeView.swift
//  hianime-clone
//
//  Created by apple on 30/08/24.
//

import SwiftUI
import AVKit

struct WatchEpisodeView: View {
    var animeName: String
    var animeId: String
    
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""
    @State private var showErrorAlert: Bool = false
    
    @State private var player = AVPlayer()
    @State private var episodesList: EpisodesList?
    @State private var animeServers: Servers = Servers(sub: [Server(serverName: "vidstreaming", serverId: 0)], dub: [Server(serverName: "vidstreaming", serverId: 0)])
    @State private var animeEpisodeLinks: StreamingLinks?
    
    @State private var selectedServer: Server?
    @State private var selectedType: String = "sub"
    @State private var currentPlayingEpisode: EpisodeItem?
    
    @State private var isServerFound: Bool = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                if isLoading {
                    loadingView
                } else {
                    ZStack {
                        VideoPlayer(player: player)
                            .frame(height: 300)
                            .cornerRadius(10)
                    }
                }
                
                Text(animeName)
                    .font(.title)
                    .padding(.top, 10)
                
                Text("Episode - \(currentPlayingEpisode?.number ?? 1)")
                    .foregroundStyle(Color.white.opacity(0.7))
                    .padding(.bottom, 10)
                
                Text("Servers")
                    .padding(.top, 26)
                    .font(.subheadline)
                    .foregroundStyle(Color.gray)
                
                Menu {
                    Section(header: Text("SUB")) {
                        ForEach(animeServers.sub.compactMap { $0 }, id: \.serverId) { server in
                            Button(server.serverName ?? "Unknown Server") {
                                selectedServer = server
                                selectedType = "sub"
                                loadStreamingLinks(retryCount: 0)
                            }
                        }
                    }
                    
                    Section(header: Text("DUB")) {
                        ForEach(animeServers.dub.compactMap { $0 }, id: \.serverId) { server in
                            Button(server.serverName ?? "Unknown Server") {
                                selectedServer = server
                                selectedType = "dub"
                                loadStreamingLinks(retryCount: 0)
                            }
                        }
                    }
                } label: {
                    HStack {
                        if let selectedServer = selectedServer {
                            HStack {
                                Text(selectedType)
                                Divider().background(Color.white)
                                Text(selectedServer.serverName!)
                            }
                        } else {
                            Text("Select Server")
                        }
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 48)
                    .background(Color.gray.opacity(0.2))
                    .foregroundStyle(Color.white)
                    .cornerRadius(8)
                }
                
                Text("Episodes")
                    .padding(.top, 26)
                    .font(.subheadline)
                    .foregroundStyle(Color.gray)
                
                if let listOfEpisodes = episodesList?.episodes {
                    EpisodesView(currentPlayingEpisode: $currentPlayingEpisode, episodes: listOfEpisodes, onEpisodeSelect: { selectedEpisode in
                        DispatchQueue.main.async {
                            resetPlayer()
                            self.currentPlayingEpisode = selectedEpisode
                            loadStreamingLinks(retryCount: 0)
                        }
                    })
                }
                
                Spacer()
            }
            .padding([.horizontal, .bottom], 26)
            .onAppear {
                loadData(retryCount: 0)
            }
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Error"),
                      message: Text("500 Internal Server Error. Please try again."),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func resetPlayer() {
        player.pause()
        player.replaceCurrentItem(with: nil)
        isLoading = true
    }
    
    func setupPlayer() {
        if let sources = animeEpisodeLinks?.sources, !sources.isEmpty, let url = sources[0]?.url {
            print("currently playing video: ", url)
            if let videoURL = URL(string: url) {
                let playerItem = AVPlayerItem(url: videoURL)
                player.replaceCurrentItem(with: playerItem)
                player.play()
            } else {
                print("Invalid URL string: \(url)")
                self.errorMessage = "Invalid URL string: \(url)"
            }
        } else {
            print("No sources available to play")
            self.errorMessage = "No sources available to play"
        }
    }
    
    func loadData(retryCount: Int) {
        guard retryCount < 3 else {
            self.errorMessage = "Failed to load data after multiple attempts."
            self.showErrorAlert = true
            return
        }
        isLoading = true
        
        APIClient.shared.makeRequest(endpoint: "\(Endpoints.LIST_EPISODES)/\(animeId)", completion: { (result: Result<EpisodesList, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let responseData):
                    print("Successfully fetched episode list: \(responseData)")
                    self.episodesList = responseData
                    
                    if let firstEpisode = responseData.episodes.first {
                        self.currentPlayingEpisode = firstEpisode
                        loadStreamingLinks(retryCount: 0)
                    }
                    isLoading = false
                case .failure(let error):
                    print("Error while fetching episode list: \(error), retrying...")
                    loadData(retryCount: retryCount + 1)
                }
            }
        })
    }
    
    func loadStreamingLinks(retryCount: Int) {
        guard retryCount < 3 else {
            self.errorMessage = "Failed to load streaming links after multiple attempts."
            self.showErrorAlert = true
            return
        }
        guard let selectedEpisode = currentPlayingEpisode else { return }
        selectedServer = animeServers.sub.first
        
        let params: [(String, String, Bool)] = [
            ("id", "\(selectedEpisode.episodeId)", false),
            ("server", selectedServer?.serverName ?? "", true),
            ("category", selectedType, true)
        ]
        
        let encodedUrl = URLUtility.urlEncode(params)
        let fullUrlString = "\(Endpoints.STREAMING_LINKS)?\(encodedUrl)"
        
        APIClient.shared.makeCustomRequest(urlString: fullUrlString) { (result: Result<StreamingLinks, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let responseData):
                    if responseData.sources.isEmpty {
                        print("Empty response, retrying...")
                        loadStreamingLinks(retryCount: retryCount + 1)
                    } else {
                        print("Successfully fetched streaming links: \(responseData)")
                        self.animeEpisodeLinks = responseData
                        setupPlayer()
                        isLoading = false
                    }
                case .failure(let error):
                    print("Error while fetching streaming links: \(error), retrying...")
                    loadStreamingLinks(retryCount: retryCount + 1)
                    isLoading = false
                }
            }
        }
    }
}

var loadingView: some View {
    VStack {
        Spacer()
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .scaleEffect(1.0)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        Spacer()
    }
    .frame(height: 300)
    .background(Color.black.opacity(0.6))
}

#Preview {
    WatchEpisodeView(
        animeName: "One Piece",
        animeId: "one-piece-100"
    )
}
