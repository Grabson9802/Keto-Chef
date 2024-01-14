//
//  FavoritesViewModel.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 14/01/2024.
//

import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var favoriteRecieps: [RecipeDetails] = []
    
    func getFavoriteRecipes() {
        favoriteRecieps = FavoritesManager.shared.getFavorites()
    }
}
