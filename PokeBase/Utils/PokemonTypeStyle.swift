//
//  PokemonTypeStyle.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 13/05/26.
//

import SwiftUI

enum PokemonTypeStyle: String {
    case normal, fire, water, electric, grass, ice, fighting, poison, ground, flying, psychic, bug, rock, ghost, dragon, dark, steel, fairy
    case unknown
    
    var backgroundColor: Color {
        switch self {
        case .fire: return .orange
        case .water: return .blue
        case .grass: return .green
        case .electric: return .yellow
        case .ice: return .cyan
        case .fighting: return .brown
        case .poison: return .purple
        case .ground: return Color(red: 0.6, green: 0.4, blue: 0.2)
        case .flying: return .mint
        case .psychic: return .pink
        case .bug: return Color(red: 0.4, green: 0.6, blue: 0.2)
        case .rock: return .gray
        case .ghost: return .indigo
        case .dragon: return .purple.opacity(0.8)
        case .dark: return .black
        case .steel: return .gray.opacity(0.8)
        case .fairy: return .pink.opacity(0.8)
        case .normal: return .gray.opacity(0.6)
        case .unknown: return .gray
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .electric, .ice, .flying: return .black
        default: return .white
        }
    }
    
    var icon: String {
        switch self {
        case .fire: return "flame.fill"
        case .water: return "drop.fill"
        case .grass: return "leaf.fill"
        case .electric: return "bolt.fill"
        case .ice: return "snowflake"
        case .fighting: return "figure.boxing"
        case .poison: return "flask.fill"
        case .ground: return "mountain.2.fill"
        case .flying: return "wind"
        case .psychic: return "brain.head.profile"
        case .bug: return "ant.fill"
        case .rock: return "diamond.fill"
        case .ghost: return "moon.stars.fill"
        case .dragon: return "star.fill"
        case .dark: return "moon.fill"
        case .steel: return "shield.fill"
        case .fairy: return "sparkles"
        case .normal: return "circle.fill"
        case .unknown: return "questionmark.circle.fill"
        }
    }
}
