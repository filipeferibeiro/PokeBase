//
//  FavoritePokemonListView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 14/05/26.
//

import SwiftData
import SwiftUI

struct FavoritePokemonListView: View {
    @Environment(FavoritesService.self) private var favoritesService
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(favoritesService.favorites) { pokemon in
                    NavigationLink(value: pokemon.asDomain) {
                        PokemonCellView(pokemon: pokemon.asDomain)
                    }
                }
                .onDelete(perform: favoritesService.removeFavorites)
            }
            .navigationTitle("Favorites")
            .navigationDestination(for: Pokemon.self) { pokemon in
                PokemonDetailView(pokemon: pokemon)
            }
        }
    }
}

#Preview {
    FavoritePokemonListView()
        .withPreviewEnvironment()
}
