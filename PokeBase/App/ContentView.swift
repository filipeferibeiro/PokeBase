//
//  ContentView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 11/05/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                PokemonListView()
            }
            
            Tab("Favorites", systemImage: "heart") {
                Text("Favorites")
            }
            
            Tab("Search", systemImage: "magnifyingglass", role: .search) {
                PokemonSearchView()
            }
        }
    }
}

#Preview {
    ContentView()
}
