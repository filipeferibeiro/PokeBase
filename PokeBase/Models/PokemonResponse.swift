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
    
    var asPokemon: Pokemon? {
        if let idString = url.split(separator: "/").last, let id = Int(idString) {
            let spriteURLString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(id).png"
            
            guard let imageURL = URL(string: spriteURLString) else { return nil }
            
            return Pokemon(id: id, name: name, imageURL: imageURL)
        }
        return nil
    }
}
