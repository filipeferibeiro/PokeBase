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
    @State private var editingMode = EditMode.inactive
    
    var pokemons: [Pokemon] {
        return favoritesService.favorites.map { $0.asDomain }
    }
    
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
                    List(selection: $selection) {
                        ForEach(pokemons) { pokemon in
                            NavigationLink(value: pokemon) {
                                PokemonCellView(pokemon: pokemon)
                            }
                        }
                        .onDelete(perform: favoritesService.removeFavorites)
                    }
                    
                }
            }
            .navigationTitle("Favorites")
            .navigationDestination(for: Pokemon.self) { pokemon in
                PokemonDetailView(pokemon: pokemon)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if editingMode == .inactive {
                        Button {
                            editingMode = .active
                            selection.removeAll()
                        } label: {
                            Text("Edit")
                        }
                    } else {
                        Button {
                            editingMode = .inactive
                            selection.removeAll()
                        } label: {
                            Text("Done")
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    if editingMode == .active {
                        Button(role: .destructive) {
                            favoritesService.deleteSelectedPokemons(selection: selection)
                            selection.removeAll()
                            editingMode = .inactive
                        } label: {
                            Label("Delete Pokémons", systemImage: "trash")
                        }
                        .disabled(selection.isEmpty)
                    }
                }
            }
            .animation(.default, value: selection.isEmpty)
            .animation(.default, value: editingMode)
            .environment(\.editMode, $editingMode)
        }
    }
}

#Preview {
    FavoritePokemonListView()
        .withPreviewEnvironment()
}
