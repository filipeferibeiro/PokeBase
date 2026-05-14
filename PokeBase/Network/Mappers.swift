//
//  Mappers.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 14/05/26.
//

import Foundation

extension PokemonDetail {
    var asDomain: Pokemon {
        let mappedTypes: [PokemonTypeStyle] = types.map { $0.type.name }.compactMap { PokemonTypeStyle(rawValue: $0) }
        let mappedMoves: [String] = moves.map { $0.move.displayName }
        let imageURL: URL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(id).png")!
        
        return Pokemon(
            id: id,
            name: name,
            imageURL: imageURL,
            stats: .init(
                height: Double(height) / 10.0,
                weight: Double(weight) / 10.0,
                types: mappedTypes,
                moves: mappedMoves
            )
        )
    }
}
