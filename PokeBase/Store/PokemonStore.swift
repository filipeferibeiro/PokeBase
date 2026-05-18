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
    enum LoadingState {
        case loading
        case success
        case error(String)
    }
    
    var state: LoadingState = .loading
    var allPokemons: [Pokemon] = []
    
    func fetchAllPokemon() async {
        guard allPokemons.isEmpty else { return }
        
        self.state = .loading
        let urlString = Constants.pokemonListURL
        
        do {
            let response: PokemonResponse = try await NetworkManager.shared.fetch(from: urlString)
            
            await MainActor.run {
                self.allPokemons = response.results.compactMap { $0.asDomain }
                self.state = .success
            }
        } catch {
            await MainActor.run {
                self.state = .error("Error on load pokemon")
                print("Error on load pokemon: \(error)")
            }
        }
    }
}
