//
//  PokemonDetailMetricsCellView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 13/05/26.
//

import SwiftUI

struct PokemonDetailMetricsCellView: View {
    var name: String
    var value: String
    var icon: String
    
    var body: some View {
        HStack {
            Label(name, systemImage: icon)
                
            
            Spacer ()
            
            Text(value)
                .font(.body.bold())
        }
    }
}

#Preview {
    PokemonDetailMetricsCellView(name: "Height", value: "0.7m", icon: "arrow.up.and.down")
}
