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
    
    @Namespace private var animationSpace
    
    var body: some View {
        NavigationStack {
            Group {
                switch store.state {
                case .loading:
                    ProgressView("Loading Pokémons")
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
                    List {
                        ForEach(store.allPokemons) { pokemon in
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
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .refreshable {
                        await store.fetchAllPokemon()
                    }
                }
            }
            .pokedexBackground()
            .navigationTitle("Pokémons")
            .navigationDestination(for: Pokemon.self) { selectedPokemon in
                PokemonDetailView(pokemon: selectedPokemon)
                    .id(selectedPokemon.id)
                    .navigationTransition(.zoom(sourceID: selectedPokemon.id, in: animationSpace))
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
