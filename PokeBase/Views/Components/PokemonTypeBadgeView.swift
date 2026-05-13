//
//  PokemonTypeView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 13/05/26.
//

import SwiftUI

struct PokemonTypeBadgeView: View {
    let typeName: String
    
    private var style: PokemonTypeStyle {
        PokemonTypeStyle(rawValue: typeName.lowercased()) ?? .unknown
    }
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: style.icon)
                .font(.body)
            
            Text(typeName.capitalized)
                .font(.callout.bold())
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .background(style.backgroundColor)
        .foregroundStyle(style.foregroundColor)
        .clipShape(Capsule())
        .shadow(color: style.backgroundColor.opacity(0.4), radius: 3, x: 0, y: 2)
    }
}

#Preview {
    VStack {
        PokemonTypeBadgeView(typeName: "fire")
        PokemonTypeBadgeView(typeName: "water")
        PokemonTypeBadgeView(typeName: "electric")
        PokemonTypeBadgeView(typeName: "grass")
    }
}
