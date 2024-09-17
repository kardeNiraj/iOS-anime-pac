//
//  SearchView.swift
//  hianime-clone
//
//  Created by apple on 13/08/24.
//

import SwiftUI
import Combine

struct SearchView: View {
    @State private var searchResult: SearchResult? = loadJSON("search-result")
    @State private var searchSuggestion: SearchSuggestions? = loadJSON("search-suggestion")
    
    // used in query
    @State private var selectedSearchId: String = "one-piece-100"
    @State private var selectedSearchText: String = "One Piece"
    @State private var page: Int = 1
    @State private var type: String = "movie"
    @State private var status: String = "finished-airing"
    @State private var rated: String = "pg-13"
    @State private var language: String = "sub"
    @State private var genres: [String] = ["action", "adventure"]
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    @State private var errorMessage: String?
    @State private var isLoading: Bool = false
    
    @State private var currentPage: Int = 1
    @State private var totalPages: Int = 1
    
    @State private var cancellables = Set<AnyCancellable>()
    private let searchTextPublisher = PassthroughSubject<String, Never>()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                // Search Box
                ZStack(alignment: .trailing) {
                    TextField("e.g. Demon Slayer", text: $searchText)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                        .onTapGesture {
                            isSearching = true
                        }
                        .onChange(of: searchText) { newValue in
                            searchTextPublisher.send(newValue)
                        }
                    
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .red))
                            .padding(.trailing, 16)
                    }
                }
                
                if isSearching && !searchText.isEmpty, let suggestions = searchSuggestion {
                    // Suggestions Dropdown
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading) {
                            ForEach(suggestions.suggestions ?? [], id: \.id) { suggestion in
                                Text(suggestion.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding([.vertical, .horizontal], 10)
                                    .background(Color(.systemGray5))
                                    .cornerRadius(8)
                                    .onTapGesture {
                                        searchText = suggestion.name
                                        selectedSearchText = suggestion.name
                                        selectedSearchId = suggestion.id
                                        isSearching = false
//                                        makeSearchRequest()
                                    }
                            }
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(8)
                        .shadow(radius: 5)
                    }
                    .frame(maxHeight: 200)
                }
                
                // searched anime
                if let animes = searchResult?.animes {
                    Text("Anime finds for: \(selectedSearchText)")
                        .font(.title2)
                    
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
                        ForEach(animes, id: \.id) { anime in
                            VStack {
                                AnimeCardSmall(anime: anime)
                            }
                            .frame(maxHeight: .infinity, alignment: .top)
                        }
                    }
                    
//                    PaginationView(currentPage: $currentPage, totalPages: totalPages, itemsPerPage: 10, totalItems: searchResult?.animes?.count!, onPageChange: { newPage in
//                        currentPage = newPage
//    //                    makeSearchRequest()
//                    })
//                    .frame(maxWidth: .infinity, alignment: .center)
                }
                
                // Popular Anime
                Text("Popular Anime")
                    .font(.title2)
                
                LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
                    ForEach(searchResult!.mostPopularAnimes ?? [], id: \.id) { anime in
                        VStack {
                            AnimeCardSmall(anime: anime)
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                }
                
                Spacer()
            }
            .onTapGesture {
                if searchText == "" {
                    isSearching = false
                }
            }
            .padding(.horizontal)
            .padding(.top, 26)
        }
        .onAppear {
            setupSearchTextSubscriber()
            //            makeSearchRequest()
        }
    }
    
    func setupSearchTextSubscriber() {
        searchTextPublisher
            .debounce(for: .milliseconds(600), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { newValue in
                print("newValue in text change: \(newValue)")
                if !newValue.isEmpty {
                    isSearching = true
                    makeSuggestionRequest(search: newValue)
                }
            }
            .store(in: &cancellables)
    }
    
    func makeSuggestionRequest(search: String) {
        isLoading = true
        APIClient.shared.makeRequest(endpoint: "\(Endpoints.SEARCH_ANIME_SUGGESTION)?q=\(search)", completion: { (result: Result<SearchSuggestions, Error>) in
            isLoading = false
            
            DispatchQueue.main.async {
                switch result {
                case .success(let responseData):
                    print("successfully fetched search suggestions: \(responseData)")
                    self.searchSuggestion = responseData
                case .failure(let error):
                    print("error while fetching search suggestions: \(error)")
                    self.errorMessage = error.localizedDescription
                }
            }
        })
        print(search)
    }
    
    func makeSearchRequest() {
        isLoading = true
        let params = [
            ("q", selectedSearchId, false),
            ("page", String(page), false),
            ("type", type, false),
            ("status", status, false),
            ("rated", rated, false),
            ("language", language, false),
            ("genres", URLUtility.urlEncodeGenres(from: genres) ?? "", false),
        ];
        
        let query = URLUtility.urlEncode(params)
        APIClient.shared.makeRequest(endpoint: "\(Endpoints.SEARCH_ANIME_BY_ID)?\(query)", completion: { (result: Result<SearchResult, Error>) in
            
            isLoading = false
            DispatchQueue.main.async {
                switch result {
                case .success(let responseData):
                    print("successfully fetched search results: \(responseData)")
                    self.searchResult = responseData
                case .failure(let error):
                    print("error while fetching search results: \(error)")
                    self.errorMessage = error.localizedDescription
                }
            }
        })
    }
}

#Preview {
    SearchView()
}
