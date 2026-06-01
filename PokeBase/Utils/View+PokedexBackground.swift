//
//  View+PokedexBackground.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 01/06/26.
//

import Foundation
import SwiftUI

struct PokedexBackgroundModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        ZStack {
            (colorScheme == .dark ? Color(white: 0.05) : Color(white: 0.98))
                .ignoresSafeArea()
            
            GeometryReader { geometry in
                let side = geometry.size.width
                
                ZStack {
                    Circle()
                        .fill(RadialGradient(gradient: Gradient(colors: [Color.red.opacity(colorScheme == .dark ? 0.7 : 0.9), Color.red.opacity(0.2), .clear]), center: .center, startRadius: 0, endRadius: side * 0.4))
                        .frame(width: side * 1.1, height: side * 1.1)
                        .position(x: side * 0.95, y: geometry.size.height * -0.05)
                        .blur(radius: 35)
                    
                    Circle()
                        .fill(RadialGradient(gradient: Gradient(colors: [Color.red.opacity(colorScheme == .dark ? 0.5 : 0.8), .clear]), center: .center, startRadius: 0, endRadius: side * 0.9))
                        .frame(width: side * 1.8, height: side * 1.8)
                        .position(x: side * 0.85, y: geometry.size.height * 0.05)
                        .blur(radius: 80)
                }
                
                ZStack {
                    Circle()
                        .fill(RadialGradient(gradient: Gradient(colors: [Color.red.opacity(colorScheme == .dark ? 0.6 : 0.8), Color.red.opacity(0.1), .clear]), center: .center, startRadius: 0, endRadius: side * 0.35))
                        .frame(width: side * 1.0, height: side * 1.0)
                        .position(x: side * 0.05, y: geometry.size.height * 1.05)
                        .blur(radius: 40)
                    
                    Circle()
                        .fill(RadialGradient(gradient: Gradient(colors: [Color.red.opacity(colorScheme == .dark ? 0.4 : 0.7), .clear]), center: .center, startRadius: 0, endRadius: side * 0.8))
                        .frame(width: side * 1.6, height: side * 1.6)
                        .position(x: side * 0.15, y: geometry.size.height * 0.95)
                        .blur(radius: 90)
                }
            }
            .ignoresSafeArea()
            
            content
        }
    }
}

extension View {
    func pokedexBackground() -> some View {
        self.modifier(PokedexBackgroundModifier())
    }
}
