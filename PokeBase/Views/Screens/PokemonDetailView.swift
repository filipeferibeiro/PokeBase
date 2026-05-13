//
//  PokemonDetailView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 11/05/26.
//

import SwiftUI

struct PokemonDetailView: View {
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
            } else if viewModel.errorMessage != nil {
                ContentUnavailableView(
                    "Error",
                    systemImage: "xmark.octagon",
                    description: Text(viewModel.errorMessage ?? "Something went wrong.")
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
                                Text(normalizeMoveName(for: move.move.name))
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(pokemon.name.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchDetail(from: pokemon)
        }
    }
    
    func normalizeMoveName(for move: String) -> String {
        let moveName = move
            .split(separator: "-")
            .map { $0.capitalized }
            .joined(separator: " ")
        
        return moveName
    }
}

#Preview {
    let pokemon = Pokemon.exampleData[0]
    
    PokemonDetailView(pokemon: pokemon)
}

