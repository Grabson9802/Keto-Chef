//
//  FavoritesManager.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 14/01/2024.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()

    private let favoritesKey = "favorites"
    private let userDefaults = UserDefaults.standard
    
    private init() {}
    
    func getFavorite(recipeId: Int, completion: @escaping ((RecipeDetails?) -> Void)) {
        if let data = userDefaults.data(forKey: favoritesKey) {
            do {
                let decoder = JSONDecoder()
                let favorites = try decoder.decode([RecipeDetails].self, from: data)
                
                for favorite in favorites {
                    if favorite.id == recipeId {
                        completion(favorite)
                    }
                }
            } catch {
                print("Error decoding favorites: \(error)")
            }
        }
    }

    func getFavorites() -> [RecipeDetails] {
        if let data = userDefaults.data(forKey: favoritesKey) {
            do {
                let decoder = JSONDecoder()
                let favorites = try decoder.decode([RecipeDetails].self, from: data)
                return favorites
            } catch {
                print("Error decoding favorites: \(error)")
            }
        }
        return []
    }

    func toggleFavorite(_ recipe: RecipeDetails) {
        var favorites = getFavorites()

        if let index = favorites.firstIndex(where: { $0.id == recipe.id }) {
            favorites.remove(at: index)
        } else {
            favorites.append(recipe)
        }

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(favorites)
            userDefaults.set(data, forKey: favoritesKey)
        } catch {
            print("Error encoding favorites: \(error)")
        }
    }

    func isFavorite(recipeId: Int) -> Bool {
        let favorites = getFavorites()
        return favorites.contains { $0.id == recipeId }
    }
}

