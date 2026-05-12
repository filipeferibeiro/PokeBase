//
//  PokemonListView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 11/05/26.
//

import SwiftUI

struct PokemonListView: View {
    @Environment(PokemonStore.self) private var store
    
    var body: some View {
        NavigationStack {
            Group {
                if store.isLoading {
                    ProgressView("Loading Pokémons")
                        .controlSize(.large)
                } else {
                    List {
                        ForEach(store.allPokemon) { pokemon in
                            NavigationLink(value: pokemon) {
                                PokemonCellView(pokemon: pokemon)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Pokémons")
            .navigationDestination(for: Pokemon.self) { selectedPokemon in
                PokemonDetailView(pokemon: selectedPokemon)
            }
            .task {
                await store.fetchAllPokemon()
            }
        }
    }
}

#Preview {
    PokemonListView()
}
