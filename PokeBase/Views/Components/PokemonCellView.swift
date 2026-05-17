//
//  PokemonCellView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 11/05/26.
//

import SwiftUI

struct PokemonCellView: View {
    @Environment(FavoritesService.self) private var favoritesService
    let pokemon: Pokemon
    
    var body: some View {
        HStack(spacing: 16) {
            AvatarImageView(url: pokemon.imageURL, size: 60)
            
            VStack(alignment: .leading) {
                Text("#\(pokemon.id)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text(pokemon.name.capitalized)
            }
            
            Spacer()
            
            if favoritesService.isFavorite(id: pokemon.id) {
                Image(systemName: "heart.fill")
                    .foregroundStyle(.red)
            }
        }
    }
}

#Preview {    
    PokemonCellView(pokemon: Pokemon.mockDetails)
        .withPreviewEnvironment()
}
