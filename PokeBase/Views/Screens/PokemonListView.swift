//
//  PokemonListView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 11/05/26.
//

import SwiftUI

struct PokemonListView: View {
    @State private var pokemons = Pokemon.exampleData
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(pokemons) { pokemon in
                    PokemonCellView(pokemon: pokemon)
                }
            }
            .navigationTitle("Pokémons")
        }
    }
}

#Preview {
    PokemonListView()
}
