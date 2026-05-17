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
    @State private var viewModel = PokemonDetailViewModel()
    let pokemon: Pokemon
    
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
            case .success(let detailedPokemon):
                renderDetail(detailedPokemon)
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Button {
                                Task {
                                    await favoritesService.toggleFavorite(for: detailedPokemon)
                                }
                            } label: {
                                Image(systemName: favoritesService.isFavorite(id: pokemon.id) ? "heart.fill" : "heart")
                            }
                        }
                    }
            }
        }
        .navigationTitle(pokemon.displayName)
        .navigationBarTitleDisplayMode(.inline)
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
            
            if let stats = detailedPokemon.stats {
                Section("Metrics") {
                    PokemonMetricsView(
                        height: detailedPokemon.formattedHeight,
                        weight: detailedPokemon.formattedWeight
                    )
                }
                
                Section("Moves") {
                    PokemonMovesView(moves: stats.moves)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PokemonDetailView(pokemon: Pokemon.mockDetails)
            .withPreviewEnvironment()
    }
}

