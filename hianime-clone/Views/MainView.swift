//
//  MainView.swift
//  hianime-clone
//
//  Created by apple on 12/08/24.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("bg1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(.all)
                    .blur(radius: 50.0)
                
                TabView(selection: $selectedTab) {
                    HomeView()
                        .applyBackground()
                        .onAppear {
                            insertFavourites()
                        }
                        .tabItem {
                            VStack {
                                Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                                Text("Home")
                            }
                            .foregroundColor(selectedTab == 0 ? .red : .gray)
                        }
                        .tag(0)
                    
                    ExploreView()
                        .applyBackground()
                        .tabItem {
                            VStack {
                                Image(systemName: selectedTab == 1 ? "wand.and.stars" : "wand.and.stars.inverse")
                                Text("Explore")
                            }
                            .foregroundColor(selectedTab == 1 ? .red : .gray)
                        }
                        .tag(1)
                    
                    SearchView()
                        .applyBackground()
                        .tabItem {
                            VStack {
                                Image(systemName: selectedTab == 2 ? "magnifyingglass" : "magnifyingglass")
                                Text("Search")
                            }
                            .foregroundColor(selectedTab == 2 ? .red : .gray)
                        }
                        .tag(2)
                    
                    DonateView()
                        .applyBackground()
                        .tabItem {
                            VStack {
                                Image(systemName: selectedTab == 3 ? "hands.sparkles.fill" : "hands.sparkles")
                                Text("Donate")
                            }
                            .foregroundColor(selectedTab == 3 ? .red : .gray)
                        }
                        .tag(3)
                    
                    FavouritesView()
                        .applyBackground()
                        .tabItem {
                            VStack {
                                Image(systemName: selectedTab == 4 ? "heart.fill" : "heart")
                                Text("Favourites")
                            }
                            .foregroundColor(selectedTab == 4 ? .red : .gray)
                        }
                        .tag(4)
                }
                .accentColor(.red)
                .padding()
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    MainView()
}
