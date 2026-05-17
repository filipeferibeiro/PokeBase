//
//  PokemonSearchView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 12/05/26.
//

import SwiftUI

struct PokemonSearchView: View {
    @Environment(PokemonStore.self) private var store
    @Environment(FavoritesService.self) private var favoritesService
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
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            let isFavorite = favoritesService.isFavorite(id: pokemon.id)
                            
                            Button {
                                Task {
                                    await favoritesService.toggleFavorite(for: pokemon)
                                }
                            } label: {
                                Label (
                                    isFavorite ? "Remove" : "Favorite",
                                    systemImage: isFavorite ? "heart.slash.fill" : "heart.fill"
                                )
                            }
                            .tint(isFavorite ? .red : .orange)
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
                viewModel.searchPokemon(from: store.allPokemons)
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Search for a Pokémon")
    }
}

#Preview {
    PokemonSearchView()
        .withPreviewEnvironment()
}
