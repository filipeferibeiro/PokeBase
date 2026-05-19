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

class PokemonRepository: PokemonRepositoryProtocol {
    private let network = NetworkManager.shared
    
    func getPokemonDetail(id: Int) async throws -> Pokemon {
        let stringURL = "\(Constants.pokemonDetailUrl)/\(id)"
        let dto: PokemonDetail = try await network.fetch(from: stringURL)
        
        var pokemon: Pokemon = dto.asDomain
        
        if let url = pokemon.imageURL {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            pokemon = pokemon.updatedWithImageData(imageData: data)
        }
        
        return pokemon
    }
}
