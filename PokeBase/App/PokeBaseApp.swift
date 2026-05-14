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
    @State private var store = PokemonStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(store)
                .modelContainer(for: FavoritePokemon.self)
        }
    }
}
