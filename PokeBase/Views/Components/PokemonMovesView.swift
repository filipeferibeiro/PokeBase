//
//  PokemonMovesView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 15/05/26.
//

import SwiftUI

struct PokemonMovesView: View {
    let moves: [String]
    
    var body: some View {
        ForEach(moves, id: \.self) { moveName in
            Text(moveName)
        }
    }
}

#Preview {
    PokemonMovesView(moves: ["Mega Punch", "Fire Punch"])
}
