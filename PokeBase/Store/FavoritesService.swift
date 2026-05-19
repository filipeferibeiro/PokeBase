//
//  FavoritesService.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 14/05/26.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
class FavoritesService {
    private var modelContext: ModelContext
    private let repository: PokemonRepositoryProtocol
    
    var favorites: [FavoritePokemon] = []
    
    init(modelContext: ModelContext, repository: PokemonRepositoryProtocol) {
        self.modelContext = modelContext
        self.repository = repository
        fetchFavorites()
    }
    
    func isFavorite(id: Int) -> Bool {
        favorites.contains { $0.id == id }
    }
    
    func toggleFavorite(for pokemon: Pokemon) async {
        if isFavorite(id: pokemon.id) {
            remove(id: pokemon.id)
            return
        }
        
        if pokemon.stats != nil {
            add(pokemon)
            return
        }
        
        do {
            let detailedPokemon = try await repository.getPokemonDetail(id: pokemon.id)
            
            add(detailedPokemon)
        } catch {
            print("Error on get Pokémon detail for favorite")
        }
    }
    
    func removeFavorites(at indexSet: IndexSet) {
        for index in indexSet {
            let favorite = favorites[index]
            withAnimation {
                remove(id: favorite.id)
            }
        }
    }
    
    func deleteSelectedPokemons(selection: Set<Int>) {
        let pokemonsToDelete = favorites.filter { selection.contains($0.id) }
        
        for pokemon in pokemonsToDelete {
            remove(id: pokemon.id)
        }
    }
    
    private func fetchFavorites() {
        let descriptor = FetchDescriptor<FavoritePokemon>(sortBy: [SortDescriptor(\.id)])
        
        do {
            favorites = try modelContext.fetch(descriptor)
        } catch {
            print("Error on search for favorites")
        }
    }
    
    private func add(_ pokemon: Pokemon) {
        guard let newFavorite = FavoritePokemon.create(from: pokemon) else { return }
        
        modelContext.insert(newFavorite)
        save()
    }
    
    private func remove(id: Int) {
        let predicate = #Predicate<FavoritePokemon> { $0.id == id }
        try? modelContext.delete(model: FavoritePokemon.self, where: predicate)
        save()
    }
    
    private func save() {
        try? modelContext.save()
        fetchFavorites()
    }
}

extension FavoritesService {
    @MainActor
    static var preview: FavoritesService {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: FavoritePokemon.self, configurations: config)
        return FavoritesService(modelContext: container.mainContext, repository: PokemonRepository())
    }
}
