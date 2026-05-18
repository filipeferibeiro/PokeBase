//
//  ContentView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 11/05/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(NavigationManager.self) private var navManager
    
    var body: some View {
        @Bindable var nav = navManager
        
        TabView(selection: $nav.selectedTab) {
            Tab(value: .home) {
                PokemonListView()
            } label: {
                Label("Home", systemImage: "house")
            }
            
            Tab(value: .favorites) {
                FavoritePokemonListView()
            } label: {
                Label("Favorites", systemImage: "heart")
            }
            
            Tab(value: .search, role: .search) {
                PokemonSearchView()
            } label: {
                Label("Search", systemImage: "magnifyingglass")
            }
        }
    }
}

#Preview {
    ContentView()
        .withPreviewEnvironment()
}
