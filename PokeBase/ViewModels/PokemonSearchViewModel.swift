//
//  PokemonSearchViewModel.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 12/05/26.
//

import Foundation
import Observation

@Observable
class PokemonSearchViewModel {
    var searchResults: [Pokemon] = []
    var searchText: String = ""
    
    func searchPokemon(from masterList: [Pokemon]) {
        let query = searchText.lowercased().trimmingCharacters(in: .whitespaces)
        
        if query.isEmpty {
            self.searchResults = []
            return
        }
        
        self.searchResults = masterList.filter {
            $0.name.lowercased().contains(query) || $0.id.description.contains(query)
        }
    }
}
