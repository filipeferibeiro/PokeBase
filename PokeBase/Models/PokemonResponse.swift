//
//  PokemonResponse.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 12/05/26.
//

import Foundation

struct PokemonResponse: Codable {
    let count: Int
    let next: String?
    let results: [PokemonResult]
}

struct PokemonResult: Codable {
    let name: String
    let url: String
}
