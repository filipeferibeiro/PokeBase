//
//  PokemonDetailViewModel.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 13/05/26.
//

import Foundation
import Observation

@Observable
class PokemonDetailViewModel {
    var detail: PokemonDetail?
    var isLoading: Bool = false
    var errorMessage: String?
    
    func fetchDetail(from pokemon: Pokemon) async {
        guard isLoading == false, detail == nil else { return }
        
        isLoading = true
        errorMessage = nil
        
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(pokemon.id)"
        
        do {
            let response: PokemonDetail = try await NetworkManager.shared.fetch(from: urlString)
            
            await MainActor.run {
                self.detail = response
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.isLoading = false
                self.errorMessage = "Error on load pokemon detail"
                print("Error on load pokemon detail: \(error)")
            }
        }
    }
}
