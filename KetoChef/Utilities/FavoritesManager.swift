//
//  FavoritesManager.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 14/01/2024.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    
    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "FavoriteRecipes"
    
    func toggleFavorite(recipeId: Int) {
        var favorites = userDefaults.array(forKey: favoritesKey) as? [Int] ?? []
        
        if let index = favorites.firstIndex(of: recipeId) {
            favorites.remove(at: index)
        } else {
            favorites.append(recipeId)
        }
        
        userDefaults.set(favorites, forKey: favoritesKey)
    }
    
    func isRecipeFavorite(recipeId: Int) -> Bool {
        let favorites = userDefaults.array(forKey: favoritesKey) as? [Int] ?? []
        return favorites.contains(recipeId)
    }
}
