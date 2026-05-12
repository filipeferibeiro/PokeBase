//
//  Preview+Extensions.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 12/05/26.
//

import Foundation
import SwiftUI

extension View {
    func withPreviewEnvironment() -> some View {
        let previewStore = PokemonStore()
        
        previewStore.allPokemons = Pokemon.exampleData
        
        return self.environment(previewStore)
    }
}
