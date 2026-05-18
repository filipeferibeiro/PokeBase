//
//  NavigationManager.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 18/05/26.
//

import Foundation
import Observation

enum AppTab {
    case home, favorites, search
}

@Observable
class NavigationManager {
    var selectedTab: AppTab = .home
    
    func goToHome() {
        self.selectedTab = .home
    }
}
