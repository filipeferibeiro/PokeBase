//
//  Constants.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 15/05/26.
//

import Foundation

struct Constants {
    static let baseURL: String = "https://pokeapi.co/api/v2"
    static let pokemonListURL: String = "\(baseURL)/pokemon?limit=10000"
    static let pokemonDetailUrl: String = "\(baseURL)/pokemon"
    
    static func pokemonImageURL(for id: Int) -> String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(id).png"
    }
}
