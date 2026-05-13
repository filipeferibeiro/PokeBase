//
//  PokemonCellView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 11/05/26.
//

import SwiftUI

struct PokemonCellView: View {
    let pokemon: Pokemon
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: pokemon.imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 60, height: 60)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 224, height: 224)
                        .foregroundStyle(.secondary)
                @unknown default:
                    EmptyView()
                }
            }
            .background(.tertiary)
            .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("#\(pokemon.id)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text(pokemon.name.capitalized)
            }
        }
    }
}

#Preview {
    let pokemon = Pokemon.exampleData[0]
    
    PokemonCellView(pokemon: pokemon)
}
