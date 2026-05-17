//
//  PokemonMetricsView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 15/05/26.
//

import SwiftUI

struct PokemonMetricsView: View {
    let height: String
    let weight: String
    
    var body: some View {
        PokemonDetailMetricsCellView(name: "Height", value: height, icon: "arrow.up.and.down")
        PokemonDetailMetricsCellView(name: "Weight", value: weight, icon: "scalemass")
    }
}

#Preview {
    PokemonMetricsView(height: "1.7m", weight: "90.4kg")
}
