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
    @Environment(NavigationManager.self) private var navManager
    
    @State private var selection = Set<Int>()
    
    var body: some View {
        NavigationStack {
            Group {
                if favoritesService.favorites.isEmpty {
                    ContentUnavailableView {
                        Label("Your Party is Empty", systemImage: "heart.fill")
                    } description: {
                        Text("Find your favorite Pokémons and add them here. They will be available even without internet.")
                    } actions: {
                        Button("Explore Pokémons") {
                            withAnimation {
                                navManager.goToHome()
                            }
                        }
                        .buttonStyle(.glassProminent)
                    }
                } else {
                    List(favoritesService.favorites, selection: $selection) { pokemon in
                        NavigationLink(value: pokemon.asDomain) {
                            PokemonCellView(pokemon: pokemon.asDomain)
                        }
                        .swipeActions {
                            Button("Delete", systemImage: "trash", role: .destructive) {
                                favoritesService.removeFavoritePokemon(id: pokemon.id)
                            }
                        }
                        .tag(pokemon.id)
                    }
                    
                }
            }
            .navigationTitle("Favorites")
            .navigationDestination(for: Pokemon.self) { pokemon in
                PokemonDetailView(pokemon: pokemon)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
            .animation(.default, value: selection.isEmpty)
        }
    }
}

#Preview {
    FavoritePokemonListView()
        .withPreviewEnvironment()
}
