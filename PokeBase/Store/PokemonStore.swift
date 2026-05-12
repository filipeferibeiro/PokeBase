//
//  PokemonStore.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 12/05/26.
//

import Foundation
import Observation

@Observable
class PokemonStore {
    var allPokemons: [Pokemon] = []
    var isLoading: Bool = false
    
    func fetchAllPokemon() async {
        guard allPokemons.isEmpty else { return }
        
        isLoading = true
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=10000"
        
        do {
            let response: PokemonResponse = try await NetworkManager.shared.fetch(from: urlString)
            
            await MainActor.run {
                self.allPokemons = response.results.compactMap { $0.asPokemon }
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.isLoading = false
                print("Error on load pokemon: \(error)")
            }
        }
    }
}
