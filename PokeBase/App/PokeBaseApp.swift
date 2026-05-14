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
    
    init() {
        do {
            container = try ModelContainer(for: FavoritePokemon.self)
        } catch {
            fatalError("Não foi possível inicializar o SwiftData")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            let favoritesService = FavoritesService(modelContext: container.mainContext)
            ContentView()
                .environment(favoritesService)
                .environment(store)
                .modelContainer(container)
        }
    }
}
