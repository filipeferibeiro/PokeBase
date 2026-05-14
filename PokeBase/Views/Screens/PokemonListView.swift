//
//  PokemonListView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 11/05/26.
//

import SwiftUI

struct PokemonListView: View {
    @Environment(PokemonStore.self) private var store
    @Environment(FavoritesService.self) private var favoritesService
    
    var body: some View {
        NavigationStack {
            Group {
                if store.isLoading {
                    ProgressView("Loading Pokémons")
                        .controlSize(.large)
                } else {
                    List {
                        ForEach(store.allPokemons) { pokemon in
                            NavigationLink(value: pokemon) {
                                PokemonCellView(pokemon: pokemon)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Pokémons")
            .navigationDestination(for: Pokemon.self) { selectedPokemon in
                PokemonDetailView(pokemon: selectedPokemon, favoritesService: favoritesService)
            }
            .task {
                await store.fetchAllPokemon()
            }
        }
    }
}

#Preview {
    PokemonListView()
        .withPreviewEnvironment()
}
