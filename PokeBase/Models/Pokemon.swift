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
}

extension Pokemon {
    static let exampleData: [Pokemon] = [
        Pokemon(id: 1, name: "Bulbasaur", imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")!),
        Pokemon(id: 4, name: "Charmander", imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png")!),
        Pokemon(id: 7, name: "Squirtle", imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png")!),
        Pokemon(id: 63, name: "Abra", imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/63.png")!),
        Pokemon(id: 448, name: "Lucario", imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/448.png")!)
    ]
}
