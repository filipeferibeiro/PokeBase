//
//  PokemonViewModel.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 12/05/26.
//

import Foundation
import Observation

@Observable
class PokemonViewModel {
    var pokemons: [Pokemon] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    func fetchPokemons() async {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=151"
        
        do {
            let response: PokemonResponse = try await NetworkManager.shared.fetch(from: urlString)
            
            self.pokemons = response.results.compactMap { $0.asPokemon }
            
            isLoading = false
        } catch {
            print("Error on loading Pokémons: \(error.localizedDescription)")
            self.errorMessage = "Was not possible to load Pokémons. Try again later."
            isLoading = false
        }
    }
}

