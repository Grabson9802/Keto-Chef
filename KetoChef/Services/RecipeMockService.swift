//
//  RecipeMockService.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

import Foundation

class RecipeMockService: RecipeServiceProtocol {
    
    func fetchRecipeDetails(for recipeId: Int, completion: @escaping (RecipeDetails?) -> Void) {
        let mockRecipeDetailed = RecipeDetails(id: 0,
                                               title: "Title",
                                               image: "https://via.placeholder.com/1920x1080",
                                               imageType: "jpg",
                                               servings: 0,
                                               readyInMinutes: 0,
                                               healthScore: 0.0,
                                               spoonacularScore: 0.0,
                                               pricePerServing: 0.0,
                                               analyzedInstructions: [],
                                               dishTypes: [],
                                               extendedIngredients: [.init(aisle: "aaa",
                                                                           amount: 0.0,
                                                                           consistency: "bbb",
                                                                           id: 0,
                                                                           image: "ccc",
                                                                           measures: .init(metric: .init(amount: 0.0,
                                                                                                         unitLong: "ddd",
                                                                                                         unitShort: "eee"),
                                                                                           us: .init(amount: 0.0,
                                                                                                     unitLong: "fff",
                                                                                                     unitShort: "ggg")),
                                                                           meta: [],
                                                                           name: "Kebab",
                                                                           original: "lll",
                                                                           originalName: "mmm",
                                                                           unit: "nnn"),
                                                                     .init(aisle: "aaa",
                                                                                                 amount: 0.0,
                                                                                                 consistency: "bbb",
                                                                                                 id: 0,
                                                                                                 image: "ccc",
                                                                                                 measures: .init(metric: .init(amount: 0.0,
                                                                                                                               unitLong: "ddd",
                                                                                                                               unitShort: "eee"),
                                                                                                                 us: .init(amount: 0.0,
                                                                                                                           unitLong: "fff",
                                                                                                                           unitShort: "ggg")),
                                                                                                 meta: [],
                                                                                                 name: "Egg",
                                                                                                 original: "lll",
                                                                                                 originalName: "mmm",
                                                                                                 unit: "nnn")],
                                               summary: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
        completion(mockRecipeDetailed)
    }
    
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
