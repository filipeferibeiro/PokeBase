//
//  PokeBaseApp.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 11/05/26.
//

import SwiftData
import SwiftUI

@main
struct PokeBaseApp: App {
    let container: ModelContainer
    
    @State private var store = PokemonStore()
    @State private var favoritesService: FavoritesService
    
    init() {
        do {
            self.container = try ModelContainer(for: FavoritePokemon.self)
            self._favoritesService = State(initialValue: FavoritesService(modelContext: container.mainContext))
        } catch {
            fatalError("Error on start SwiftData")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(favoritesService)
                .environment(store)
                .modelContainer(container)
        }
    }
}
