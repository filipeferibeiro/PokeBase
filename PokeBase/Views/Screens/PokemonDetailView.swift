//
//  PokemonDetailView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 11/05/26.
//

import SwiftData
import SwiftUI

struct PokemonDetailView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var viewModel = PokemonDetailViewModel()
    let pokemon: Pokemon
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                VStack {
                    ProgressView()
                        .controlSize(.large)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            } else if let errorMessage = viewModel.errorMessage {
                ContentUnavailableView(
                    "Error",
                    systemImage: "xmark.octagon",
                    description: Text(errorMessage)
                )
            } else {
                List {
                    Section {
                        VStack(alignment: .center, spacing: 16) {
                            AvatarImageView(url: pokemon.imageURL, size: 224)
                            
                            if let detail = viewModel.detail {
                                HStack(spacing: 16) {
                                    ForEach(detail.types, id: \.slot) { type in
                                        PokemonTypeBadgeView(typeName: type.type.name)
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    
                    if let detail = viewModel.detail {
                        Section("Metrics") {
                            PokemonDetailMetricsCellView(name: "Height", value: "\(Double(detail.height) / 10)m", icon: "arrow.up.and.down")
                            PokemonDetailMetricsCellView(name: "Weight", value: "\(Double(detail.weight) / 10)kg", icon: "scalemass")
                        }
                        
                        Section("Moves") {
                            ForEach(detail.moves, id: \.move.name) { move in
                                Text(move.move.displayName)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(pokemon.name.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Favorite", systemImage: "heart", action: saveFavorite)
            }
        }
        .task {
            await viewModel.fetchDetail(from: pokemon)
        }
    }
    
    func saveFavorite() {
        guard let pokemonSaveData = viewModel.generateFavoriteData() else {
            return
        }
        
        modelContext.insert(pokemonSaveData)
    }
}

#Preview {
    let pokemon = Pokemon.exampleData[0]
    
    NavigationStack {
        PokemonDetailView(pokemon: pokemon)
    }
}

