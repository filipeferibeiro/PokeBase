//
//  FavoritePokemonListView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 14/05/26.
//

import SwiftData
import SwiftUI

struct FavoritePokemonListView: View {
    @Query private var favoritePokemons: [FavoritePokemon]
    
    var body: some View {
        List {
            ForEach(favoritePokemons) { pokemon in
                Text(pokemon.name)
            }
        }
    }
}

#Preview {
    FavoritePokemonListView()
}
