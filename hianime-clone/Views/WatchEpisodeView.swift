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
    
    @State private var selectedServer: Server?
    @State private var selectedType: String = "sub"
    @State private var currentPlayingEpisode: Int = 1
    
    @State private var player = AVPlayer()
    @State private var episodesList: EpisodesList?
    @State private var animeServers: Servers?
    @State private var animeEpisodeLinks: StreamingLinks?
    
    @State private var serverIndex: Int = 0
    @State private var hasTriedVidstreaming: Bool = false
    @State private var isServerFound: Bool = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                if isLoading {
                    loadingView
                } else {
                    VideoPlayer(player: player)
                        .frame(height: 300)
                        .cornerRadius(10)
                }
                
                Text(animeName)
                    .font(.title)
                    .padding(.top, 10)
                
                Text("Episode - \(currentPlayingEpisode)")
                    .foregroundStyle(Color.white.opacity(0.7))
                    .padding(.bottom, 10)
                
                Text("Servers")
                    .padding(.top, 26)
                    .font(.subheadline)
                    .foregroundStyle(Color.gray)
                
                Menu {
                    if let subServers = animeServers?.sub, !subServers.isEmpty {
                        Section(header: Text("SUB")) {
                            ForEach(subServers.compactMap { $0 }, id: \.serverId) { server in
                                Button(server.serverName!) {
                                    selectedServer = server
                                    selectedType = "sub"
                                    loadStreamingLinks()
                                }
                            }
                        }
                    }
                    
                    if let dubServers = animeServers?.dub, !dubServers.isEmpty {
                        Section(header: Text("DUB")) {
                            ForEach(dubServers.compactMap { $0 }, id: \.serverId) { server in
                                Button(server.serverName!) {
                                    selectedServer = server
                                    selectedType = "dub"
                                    loadStreamingLinks()
                                }
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
                            self.player = AVPlayer()
                            self.currentPlayingEpisode = selectedEpisode
                            self.hasTriedVidstreaming = false
                            loadStreamingLinks()
                        }
                    })
                }
                
                Spacer()
            }
            .padding([.horizontal, .bottom], 26)
            .onAppear {
                loadData()
            }
            .alert(isPresented: $isLoading) {
                Alert(title: Text("Loading..."), message: Text("Please wait while the data is loading."))
            }
            .alert(isPresented: Binding<Bool>(
                get: { !errorMessage.isEmpty },
                set: { _ in errorMessage = "" }
            )) {
                Alert(title: Text("Error"), message: Text(errorMessage))
            }
        }
    }
    
    func setupPlayer() {
        if let sources = animeEpisodeLinks?.sources, !sources.isEmpty, let url = sources[0]?.url {
            print("currently playing video: ", url)
            if let videoURL = URL(string: url) {
                player = AVPlayer(url: videoURL)
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
    
    func loadData() {
        isLoading = true
        
        // Load anime servers from API
        APIClient.shared.makeRequest(endpoint: "\(Endpoints.EPISODE_SERVERS)?episodeId=\(animeId)%3Fep%3D\(currentPlayingEpisode)", completion: { (result: Result<Servers, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let responseData):
                    print("Successfully fetched servers: \(responseData)")
                    self.animeServers = responseData
                    self.selectedServer = animeServers?.sub?.first
                    self.selectedType = "sub"
                    loadStreamingLinks()
                case .failure(let error):
                    print("Error while fetching servers: \(error)")
                    self.errorMessage = "Unable to fetch servers!"
                }
                isLoading = false
            }
        })
        
        // Load episodes
        APIClient.shared.makeRequest(endpoint: "\(Endpoints.LIST_EPISODES)/\(animeId)", completion: { (result: Result<EpisodesList, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let responseData):
                    print("Successfully fetched episode list: \(responseData)")
                    self.episodesList = responseData
                case .failure(let error):
                    print("Error while fetching episode list: \(error)")
                    self.errorMessage = error.localizedDescription
                }
            }
        })
    }
    
    func loadStreamingLinks() {
        guard let animeServers = animeServers else { return }
        
        var serverIndex = 0
        var isServerFound = false
        
        func tryNextServer() {
            guard let subServers = animeServers.sub else {
                print("No servers available to try")
                self.errorMessage = "No servers available to try"
                return
            }
            
            // Check if we have tried all sub servers and haven't tried "vidstreaming" yet
            if serverIndex >= subServers.count {
                if !hasTriedVidstreaming {
                    selectedServer = Server(serverName: "vidstreaming", serverId: serverIndex+1)
                    hasTriedVidstreaming = true
                } else {
                    print("No more servers to try, including fallback 'vidstreaming' server")
                    isLoading = false
                    self.errorMessage = "No servers available to load the episode"
                    return
                }
            } else {
                selectedServer = subServers[serverIndex]
                serverIndex += 1
            }

            isLoading = true
            
            guard let selectedServer else { return }
            
            let params: [(String, String, Bool)] = [
                ("id", "\(animeId)%3Fep%3D\(currentPlayingEpisode)", false),
                ("server", selectedServer.serverName ?? "", true),
                ("category", selectedType, true)
            ]
            
            let encodedUrl = URLUtility.urlEncode(params)
            let fullUrlString = "\(Endpoints.STREAMING_LINKS)?\(encodedUrl)"
            
            print(fullUrlString)
            
            APIClient.shared.makeCustomRequest(urlString: fullUrlString) { (result: Result<StreamingLinks, Error>) in
                DispatchQueue.main.async {
                    isLoading = false
                    switch result {
                    case .success(let responseData):
                        if responseData.sources.isEmpty {
                            print("Empty response, trying next server...")
                            tryNextServer()
                        } else {
                            print("Successfully fetched streaming links: \(responseData)")
                            self.animeEpisodeLinks = responseData
                            setupPlayer()
                            isServerFound = true
                        }
                    case .failure(let error):
                        print("Error while fetching streaming links: \(error)")
                        self.errorMessage = error.localizedDescription
                        if !isServerFound {
                            tryNextServer()
                        }
                    }
                }
            }
        }

        tryNextServer()
    }
}

var loadingView: some View {
    VStack {
        Spacer()
        Text("Loading episode...")
            .font(.system(size: 16))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .multilineTextAlignment(.center)
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
