//
//  Preview+Extensions.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 12/05/26.
//

import Foundation
import SwiftData
import SwiftUI

extension View {
    @MainActor
    func withPreviewEnvironment() -> some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: FavoritePokemon.self, configurations: config)
        
        if let bulbasaur = Pokemon.mockList.first,
           let favoriteEntity = FavoritePokemon.create(from: bulbasaur) {
            container.mainContext.insert(favoriteEntity)
        }
        
        let previewStore = PokemonStore()
        previewStore.allPokemons = Pokemon.mockList
        
        let favoritesService = FavoritesService(modelContext: container.mainContext, repository: PokemonRepository())
        
        let navigationManager = NavigationManager()
        
        return self
            .environment(navigationManager)
            .environment(previewStore)
            .environment(favoritesService)
            .modelContainer(container)
    }
}
