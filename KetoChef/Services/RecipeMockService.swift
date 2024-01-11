//
//  RecipeMockService.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

import Foundation

class RecipeMockService: RecipeServiceProtocol {
    
    func fetchRecipeDetails(for recipeId: Int, completion: @escaping (RecipeDetails?) -> Void) {
        let mockRecipeDetailed = RecipeDetails(id: 0, title: "Title", image: "https://via.placeholder.com/600x400", summary: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", extendedIngredients: [], analyzedInstructions: [])
        completion(mockRecipeDetailed)
    }
    
    func fetchRecipes(completion: @escaping (RecipeResponse?) -> Void) {
        let mockRecipes = RecipeResponse(results: [
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
        ])

        completion(mockRecipes)
    }
}
