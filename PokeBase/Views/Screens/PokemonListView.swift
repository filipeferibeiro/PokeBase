//
//  PokemonListView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 11/05/26.
//

import SwiftUI

struct PokemonListView: View {
    @State private var viewModel = PokemonViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.pokemons.isEmpty {
                    ProgressView("Loading Pokémons")
                        .controlSize(.large)
                } else if let error = viewModel.errorMessage {
                    ContentUnavailableView {
                        Label("Connection error", systemImage: "wifi.exclamationmark")
                    } description: {
                        Text(error)
                    } actions: {
                        Button("Try again") {
                            Task { await viewModel.fetchPokemons() }
                        }
                    }
                } else {
                    List {
                        ForEach(viewModel.pokemons) { pokemon in
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
                await viewModel.fetchPokemons()
            }
        }
    }
}

#Preview {
    PokemonListView()
}
