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
        let imageURL: URL = URL(string: Constants.pokemonImageURL(for: id))!
        
        return Pokemon(
            id: id,
            name: name,
            imageURL: imageURL,
            stats: .init(
                height: Double(height),
                weight: Double(weight),
                types: mappedTypes,
                moves: mappedMoves
            )
        )
    }
}

extension FavoritePokemon {
    var asDomain: Pokemon {
        Pokemon(
            id: id,
            name: name,
            imageURL: imageURL,
            stats: .init(
                height: height,
                weight: weight,
                types: typesRawValues.compactMap { PokemonTypeStyle(rawValue: $0) },
                moves: moves
            )
        )
    }

    static func create(from pokemon: Pokemon) -> FavoritePokemon? {
        guard let stats = pokemon.stats else { return nil }
        
        return FavoritePokemon(
            id: pokemon.id,
            name: pokemon.name,
            imageURL: pokemon.imageURL,
            typesRawValues: stats.types.map { $0.rawValue },
            height: stats.height,
            weight: stats.weight,
            moves: stats.moves
        )
    }
}

extension PokemonResult {
    var asDomain: Pokemon? {
        if let idString = url.split(separator: "/").last, let id = Int(idString) {
            let spriteURLString = Constants.pokemonImageURL(for: id)
            
            guard let imageURL = URL(string: spriteURLString) else { return nil }
            
            return Pokemon(
                id: id,
                name: name,
                imageURL: imageURL,
                stats: nil
            )
        }
        return nil
    }
}
