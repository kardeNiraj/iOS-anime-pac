//
//  MainView.swift
//  hianime-clone
//
//  Created by apple on 12/08/24.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Int = 0
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.red
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.red]
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
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
                        }
                        .tag(0)
                    
                    ExploreView()
                        .applyBackground()
                        .tabItem {
                            VStack {
                                Image(systemName: selectedTab == 1 ? "wand.and.stars" : "wand.and.stars.inverse")
                                Text("Explore")
                            }
                        }
                        .tag(1)
                    
                    SearchView()
                        .applyBackground()
                        .tabItem {
                            VStack {
                                Image(systemName: "magnifyingglass")
                                Text("Search")
                            }
                        }
                        .tag(2)
                    
                    DonateView()
                        .applyBackground()
                        .tabItem {
                            VStack {
                                Image(systemName: selectedTab == 3 ? "hands.sparkles.fill" : "hands.sparkles")
                                Text("Donate")
                            }
                        }
                        .tag(3)
                    
                    FavouritesView()
                        .applyBackground()
                        .tabItem {
                            VStack {
                                Image(systemName: selectedTab == 4 ? "heart.fill" : "heart")
                                Text("Favourites")
                            }
                        }
                        .tag(4)
                }
                .accentColor(.gray)
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
