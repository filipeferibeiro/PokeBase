//
//  PokemonRepository.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 14/05/26.
//

import Foundation
import Observation

protocol PokemonRepositoryProtocol {
    func getPokemonDetail(id: Int) async throws -> Pokemon
}

@Observable
class PokemonRepository: PokemonRepositoryProtocol {
    private let network = NetworkManager.shared
    
    func getPokemonDetail(id: Int) async throws -> Pokemon {
        let stringURL = "https://pokeapi.co/api/v2/pokemon/\(id)"
        let dto: PokemonDetail = try await network.fetch(from: stringURL)
        
        return dto.asDomain
    }
}
