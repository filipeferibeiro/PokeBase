//
//  PokemonCellView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 11/05/26.
//

import SwiftUI

struct PokemonCellView: View {
    let pokemon = Pokemon.exampleData[0]
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: pokemon.imageURL)
                .frame(width: 60, height: 60)
                .background(.tertiary)
                .clipShape(Circle())
            Text(pokemon.name)
        }
    }
}

#Preview {
    PokemonCellView()
}
