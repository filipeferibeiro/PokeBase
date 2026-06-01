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
    
    @Namespace private var animationSpace
    
    var body: some View {
        NavigationStack {
        Group {
            switch store.state {
            case .loading:
                ProgressView()
                    .controlSize(.large)
                
            case .error(let error):
                ContentUnavailableView {
                    Label("Error", systemImage: "xmark.octagon")
                } description: {
                    Text(error)
                } actions: {
                    Button("Try again") {
                        Task {
                            await store.fetchAllPokemon()
                        }
                    }
                }
                
            case .success:
                renderSuccess()
            }
        }
        .pokedexBackground()
        .navigationTitle("Search Pokémons")
        .navigationDestination(for: Pokemon.self) { pokemon in
            PokemonDetailView(pokemon: pokemon)
                .id(pokemon.id)
                .navigationTransition(.zoom(sourceID: pokemon.id, in: animationSpace))
        }
        .animation(.default, value: viewModel.searchResults)
        .animation(.default, value: viewModel.searchText.isEmpty)
        .onChange(of: viewModel.searchText) {
            viewModel.searchPokemon(from: store.allPokemons)
        }
        }
        .searchable(text: $viewModel.searchText, prompt: "Search for a Pokémon")
    }
    
    func renderSuccess() -> some View {
        Group {
            if viewModel.searchText.isEmpty {
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
                    .listCellProps()
                    .matchedTransitionSource(id: pokemon.id, in: animationSpace)
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
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
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
            }
        }
    }
}

#Preview {
    PokemonSearchView()
        .withPreviewEnvironment()
}
