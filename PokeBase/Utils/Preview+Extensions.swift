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
    func withPreviewEnvironment() -> some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: FavoritePokemon.self, configurations: config)
        
        let previewStore = PokemonStore()
        previewStore.allPokemons = Pokemon.mockList
        
        let favoritesService = FavoritesService(modelContext: container.mainContext)
        
        return self
            .environment(previewStore)
            .environment(favoritesService)
            .modelContainer(container)
    }
}
