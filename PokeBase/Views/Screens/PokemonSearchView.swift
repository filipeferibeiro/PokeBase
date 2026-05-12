//
//  PokemonSearchView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 12/05/26.
//

import SwiftUI

struct PokemonSearchView: View {
    @Environment(PokemonStore.self) private var store
    @State private var viewModel = PokemonSearchViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if store.isLoading {
                    ProgressView()
                        .controlSize(.large)
                } else if viewModel.searchText.isEmpty {
                    ContentUnavailableView(
                        "Search Pokémons",
                        systemImage: "magnifyingglass",
                        description: Text("Start typing a name to see results.")
                    )
                } else if viewModel.searchResults.isEmpty {
                    ContentUnavailableView.search(text: viewModel.searchText)
                } else {
                    List(viewModel.searchResults) { pokemon in
                        NavigationLink(value: pokemon) {
                            PokemonCellView(pokemon: pokemon)
                        }
                    }
                }
            }
            .navigationTitle("Search Pokémons")
            .navigationDestination(for: Pokemon.self) { pokemon in
                PokemonDetailView(pokemon: pokemon)
            }
            .animation(.default, value: viewModel.searchResults)
            .animation(.default, value: viewModel.searchText.isEmpty)
            .onChange(of: viewModel.searchText) {
                viewModel.searchPokemon(from: store.allPokemon)
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Search for a Pokémon")
    }
}

#Preview {
    PokemonSearchView()
}
