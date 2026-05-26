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
            Tab("Home", systemImage: "house", value: .home) {
                PokemonListView()
            }
            
            Tab("Favorites", systemImage: "heart", value: .favorites) {
                FavoritePokemonListView()
            }
            
            Tab("Search", systemImage: "magnifyingglass", value: .search, role: .search) {
                PokemonSearchView()
            }
        }
    }
}

#Preview {
    ContentView()
        .withPreviewEnvironment()
}
