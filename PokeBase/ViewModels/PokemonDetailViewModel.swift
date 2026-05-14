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
        case success(Pokemon, isFavorite: Bool)
        case error(String)
    }
    
    var state: ViewState = .loading
    private let repository: PokemonRepositoryProtocol
    private let favoritesService: FavoritesService
    
    init(
        repository: PokemonRepositoryProtocol = PokemonRepository(),
        favoritesService: FavoritesService
    ) {
        self.repository = repository
        self.favoritesService = favoritesService
    }
    
    func loadDetail(for pokemon: Pokemon) async {
        state = .loading
        
        do {
            let detailed = try await repository.getPokemonDetail(id: pokemon.id)
            let isFav = favoritesService.isFavorite(id: pokemon.id)
            state = .success(detailed, isFavorite: isFav)
        } catch {
            state = .error("Something did wrong on load pokémon detail")
        }
    }
    
    func toggleFavorite(for pokemon: Pokemon) {
        favoritesService.toggleFavorite(for: pokemon)
        if case .success(let p, _) = state {
            state = .success(p, isFavorite: favoritesService.isFavorite(id: p.id))
        }
    }
}
