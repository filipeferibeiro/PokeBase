//
//  PokemonDetail.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 13/05/26.
//

import Foundation

struct PokemonDetail: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [PokemonType]
    let moves: [PokemonMove]
    
    var imageURL: URL {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(id).png")!
    }
}

struct PokemonType: Codable {
    let slot: Int
    let type: PokemonTypeInfo
    
    struct PokemonTypeInfo: Codable {
        let name: String
    }
}

struct PokemonMove: Codable {
    let move: PokemonMoveInfo
    
    struct PokemonMoveInfo: Codable {
        let name: String
        
        var displayName: String {
            return name
                .split(separator: "-")
                .map { $0.capitalized }
                .joined(separator: " ")
        }
    }
}
