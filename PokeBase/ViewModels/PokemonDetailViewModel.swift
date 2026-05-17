//
//  PokemonDetailViewModel.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 13/05/26.
//

import Foundation
import Observation

@Observable
class PokemonDetailViewModel {
    enum ViewState {
        case loading
        case success(Pokemon)
        case error(String)
    }
    
    var state: ViewState = .loading
    private let repository: PokemonRepositoryProtocol
    
    init(
        repository: PokemonRepositoryProtocol = PokemonRepository()
    ) {
        self.repository = repository
    }
    
    func loadDetail(for pokemon: Pokemon) async {
        state = .loading
        
        if pokemon.stats != nil {
            state = .success(pokemon)
            return
        }
        
        do {
            let detailed = try await repository.getPokemonDetail(id: pokemon.id)
            state = .success(detailed)
        } catch {
            state = .error("Something did wrong on load pokémon detail")
        }
    }
}
