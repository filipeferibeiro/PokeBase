//
//  PokemonDetailView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 11/05/26.
//

import SwiftData
import SwiftUI

struct PokemonDetailView: View {
    @Environment(FavoritesService.self) private var favoritesService
    @State private var viewModel: PokemonDetailViewModel
    let pokemon: Pokemon
    
    init(pokemon: Pokemon, favoritesService: FavoritesService) {
        self.pokemon = pokemon
        self._viewModel = State(initialValue: PokemonDetailViewModel(favoritesService: favoritesService))
    }
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .controlSize(.large)
            case .error(let message):
                ContentUnavailableView(
                    "Error",
                    systemImage: "xmark.octagon",
                    description: Text(message)
                )
            case .success(let detailedPokemon, _):
                renderDetail(detailedPokemon)
            }
        }
        .navigationTitle(pokemon.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    favoritesService.toggleFavorite(for: pokemon)
                } label: {
                    Image(systemName: favoritesService.isFavorite(id: pokemon.id) ? "heart.fill" : "heart")
                }
            }
        }
        .task {
            await viewModel.loadDetail(for: pokemon)
        }
    }
    
    func renderDetail(_ detailedPokemon: Pokemon) -> some View {
        List {
            Section {
                VStack(alignment: .center, spacing: 16) {
                    AvatarImageView(url: pokemon.imageURL, size: 224)
                    
                    HStack(spacing: 16) {
                        ForEach(detailedPokemon.stats?.types ?? [], id: \.self) { typeStyle in
                            PokemonTypeBadgeView(typeName: typeStyle.rawValue)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            
            Section("Metrics") {
                PokemonDetailMetricsCellView(name: "Height", value: detailedPokemon.formattedHeight, icon: "arrow.up.and.down")
                PokemonDetailMetricsCellView(name: "Weight", value: detailedPokemon.formattedWeight, icon: "scalemass")
            }
            
            Section("Moves") {
                ForEach(detailedPokemon.stats?.moves ?? [], id: \.self) { moveName in
                    Text(moveName)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PokemonDetailView(pokemon: Pokemon.mockDetails, favoritesService: .preview)
    }
}

