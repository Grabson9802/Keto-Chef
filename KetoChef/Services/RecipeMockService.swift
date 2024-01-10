//
//  RecipeMockService.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

import Foundation

class RecipeMockService: RecipeServiceProtocol {
    func fetchRecipes(completion: @escaping ([Recipe]?) -> Void) {
        let mockRecipes = [
            Recipe(id: 1, title: "Mock Recipe 1", image: "system"),
            Recipe(id: 2, title: "Mock Recipe 2", image: "system"),
            Recipe(id: 3, title: "Mock Recipe 3", image: "system"),
            Recipe(id: 4, title: "Mock Recipe 4", image: "system"),
            Recipe(id: 5, title: "Mock Recipe 5", image: "system"),
            Recipe(id: 6, title: "Mock Recipe 6", image: "system"),
            Recipe(id: 7, title: "Mock Recipe 7", image: "system"),
            Recipe(id: 8, title: "Mock Recipe 8", image: "system"),
            Recipe(id: 9, title: "Mock Recipe 9", image: "system"),
            Recipe(id: 10, title: "Mock Recipe 10", image: "system"),
        ]

        completion(mockRecipes)
    }
}
