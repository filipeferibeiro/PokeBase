//
//  FavoritePokemon.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 14/05/26.
//

import Foundation
import SwiftData

@Model
class FavoritePokemon {
    var id: Int
    var name: String
    var imageURL: URL
    
    var types: [PokemonTypeStyle]
    
    var height: Int
    var weight: Int
    
    var moves: [String]
    
    init(id: Int, name: String, imageURL: URL, types: [PokemonTypeStyle], height: Int, weight: Int, moves: [String]) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.types = types
        self.height = height
        self.weight = weight
        self.moves = moves
    }
}
