//
//  View+ListCellProps.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 01/06/26.
//

import Foundation
import SwiftUI

struct ListCellPropsModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .glassEffect(.regular, in: .rect(cornerRadius: 20))
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 0, leading: 12, bottom: 12, trailing: 12))
    }
}

extension View {
    func listCellProps() -> some View {
        self.modifier(ListCellPropsModifier())
    }
}
