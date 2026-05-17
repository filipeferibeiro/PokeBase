//
//  FavoritePokemon.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 14/05/26.
//

import Foundation
import SwiftData

@Model
final class FavoritePokemon: Identifiable {
    @Attribute(.unique)
    var id: Int
    var name: String
    var imageURL: URL
    var typesRawValues: [String]
    var height: Double
    var weight: Double
    var moves: [String]
    
    var types: [PokemonTypeStyle] {
        return typesRawValues.compactMap { PokemonTypeStyle(rawValue: $0) }
    }
    
    init(id: Int, name: String, imageURL: URL, typesRawValues: [String], height: Double, weight: Double, moves: [String]) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.typesRawValues = typesRawValues
        self.height = height
        self.weight = weight
        self.moves = moves
    }
    
}
