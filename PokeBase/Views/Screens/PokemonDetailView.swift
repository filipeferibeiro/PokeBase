//
//  PokemonDetailView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 11/05/26.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            AsyncImage(url: pokemon.imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 224, height: 224)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 224, height: 224)
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
            
            Text(pokemon.name.capitalized)
                .font(.title.bold())
        }
    }
}

#Preview {
    let pokemon = Pokemon.exampleData[0]
    
    PokemonDetailView(pokemon: pokemon)
}
