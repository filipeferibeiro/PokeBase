//
//  FavoritesService.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 14/05/26.
//

import Foundation
import SwiftData

@Observable
class FavoritesService {
    private var modelContext: ModelContext
    
    var favorites: [FavoritePokemon] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchFavorites()
    }
    
    func isFavorite(id: Int) -> Bool {
        favorites.contains { $0.id == id }
    }
    
    func toggleFavorite(for pokemon: Pokemon) {
        if isFavorite(id: pokemon.id) {
            remove(id: pokemon.id)
            return
        }
        
        add(pokemon)
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
        return FavoritesService(modelContext: container.mainContext)
    }
}
