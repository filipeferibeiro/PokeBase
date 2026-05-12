//
//  PokemonResultDetail.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 12/05/26.
//

import Foundation

struct PokemonResultDetail: Codable {
    let id: Int
    let name: String
    let sprites: Sprites
    
    struct Sprites: Codable {
        let frontDefault: String?
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
    
    var asPokemon: Pokemon? {
        guard let spriteString = sprites.frontDefault, let imageURL = URL(string: spriteString) else {
            return nil
        }
        
        return Pokemon(id: id, name: name, imageURL: imageURL)
    }
}
