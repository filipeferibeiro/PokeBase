//
//  Pokemon.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 11/05/26.
//

import Foundation

struct Pokemon: Hashable, Identifiable {
    let id: Int
    let name: String
    let imageURL: URL
    let stats: Stats?
    
    struct Stats: Hashable {
        let height: Double
        let weight: Double
        let types: [PokemonTypeStyle]
        let moves: [String]
    }
    
    var displayName: String { name.capitalized }
    
    var formattedHeight: String {
        guard let height = stats?.height else { return "--" }
        return String(format: "%.1fm", Double(height) / 10.0)
    }
    
    var formattedWeight: String {
        guard let weight = stats?.weight else { return "--" }
        return String(format: "%.1fkg", Double(weight) / 10.0)
    }
}

extension Pokemon {
    static let mockDetails = Pokemon(
        id: 1,
        name: "bulbasaur",
        imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png")!,
        stats: Stats(
            height: 7,
            weight: 69,
            types: [.grass, .poison],
            moves: ["razor-leaf", "tackle", "vine-whip"]
        )
    )
    
    static let mockList: [Pokemon] = [
        mockDetails,
        Pokemon(
            id: 4,
            name: "charmander",
            imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/4.png")!,
            stats: Stats(
                height: 6,
                weight: 85,
                types: [.fire],
                moves: ["ember", "scratch"]
            )
        ),
        Pokemon(
            id: 7,
            name: "squirtle",
            imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/7.png")!,
            stats: Stats(
                height: 5,
                weight: 90,
                types: [.water],
                moves: ["water-gun", "tail-whip"]
            )
        )
    ]
}
