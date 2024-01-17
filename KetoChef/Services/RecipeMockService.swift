//
//  RecipeMockService.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

import Foundation

class RecipeMockService: RecipeServiceProtocol {
    static let shared = RecipeMockService()
    
    private init() {}
    
    func fetchAnalyzedInstructions(for recipeId: Int, completion: @escaping (Result<[CookingSteps], Error>) -> Void) {
        let mockCookingSteps = [CookingSteps(name: "1",
                                             steps: [
                                                .init(number: 1,
                                                      step: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                                      ingredients: [
                                                        .init(id: 0, 
                                                              name: "Name",
                                                              image: "https://via.placeholder.com/1920x1080")
                                                      ])
                                             ]),
                                CookingSteps(name: "2",
                                             steps: [
                                                .init(number: 1,
                                                      step: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                                      ingredients: [
                                                        .init(id: 0, 
                                                              name: "Name",
                                                              image: "https://via.placeholder.com/1920x1080")
                                                      ])
                                             ])
        ]
        completion(.success(mockCookingSteps))
    }
    
    func fetchRecipeDetails(for recipeId: Int, completion: @escaping (Result<RecipeDetails, Error>) -> Void) {
        let mockDetailRecipes = [RecipeDetails(id: 0,
                                               title: "Keto Pizza",
                                               image: "https://via.placeholder.com/1920x1080",
                                               summary: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                               aggregateLikes: 100,
                                               extendedIngredients: [
                                                .init(id: 0,
                                                      name: "Cheese cheddar",
                                                      amount: 150,
                                                      measures: .init(metric: .init(unitLong: "g"))),
                                                .init(id: 1,
                                                      name: "Egg",
                                                      amount: 2,
                                                      measures: .init(metric: .init(unitLong: "Pieces"))),
                                                .init(id: 2,
                                                      name: "Salami",
                                                      amount: 80,
                                                      measures: .init(metric: .init(unitLong: "g")))
                                               ]),
                                 RecipeDetails(id: 1,
                                               title: "Keto Hamburger",
                                               image: "https://via.placeholder.com/1920x1080",
                                               summary: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                               aggregateLikes: 100,
                                               extendedIngredients: [
                                                .init(id: 0,
                                                      name: "Cheese cheddar",
                                                      amount: 150,
                                                      measures: .init(metric: .init(unitLong: "g"))),
                                                .init(id: 1,
                                                      name: "Egg",
                                                      amount: 2,
                                                      measures: .init(metric: .init(unitLong: "Pieces"))),
                                                .init(id: 2,
                                                      name: "Salami",
                                                      amount: 80,
                                                      measures: .init(metric: .init(unitLong: "g")))
                                               ]),
                                 RecipeDetails(id: 2,
                                               title: "Keto Muffin",
                                               image: "https://via.placeholder.com/1920x1080",
                                               summary: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                               aggregateLikes: 100,
                                               extendedIngredients: [
                                                .init(id: 0,
                                                      name: "Cheese cheddar",
                                                      amount: 150,
                                                      measures: .init(metric: .init(unitLong: "g"))),
                                                .init(id: 1,
                                                      name: "Egg",
                                                      amount: 2,
                                                      measures: .init(metric: .init(unitLong: "Pieces"))),
                                                .init(id: 2,
                                                      name: "Salami",
                                                      amount: 80,
                                                      measures: .init(metric: .init(unitLong: "g")))
                                               ])
        ]
        completion(.success(mockDetailRecipes.randomElement()!))
    }
    
    func fetchRecipes(offset: Int = 0, sort: SortingOption, completion: @escaping (Result<RecipeResponse, Error>) -> Void) {
        let mockRecipes = RecipeResponse(results: [
            Recipe(id: 1, title: "Mock Recipe 1", image: "https://via.placeholder.com/1920x1080"),
            Recipe(id: 2, title: "Mock Recipe 2", image: "https://via.placeholder.com/1920x1080"),
            Recipe(id: 3, title: "Mock Recipe 3", image: "https://via.placeholder.com/1920x1080"),
            Recipe(id: 4, title: "Mock Recipe 4", image: "https://via.placeholder.com/1920x1080"),
            Recipe(id: 5, title: "Mock Recipe 5", image: "https://via.placeholder.com/1920x1080"),
            Recipe(id: 6, title: "Mock Recipe 6", image: "https://via.placeholder.com/1920x1080"),
            Recipe(id: 7, title: "Mock Recipe 7", image: "https://via.placeholder.com/1920x1080"),
            Recipe(id: 8, title: "Mock Recipe 8", image: "https://via.placeholder.com/1920x1080"),
            Recipe(id: 9, title: "Mock Recipe 9", image: "https://via.placeholder.com/1920x1080"),
            Recipe(id: 10, title: "Mock Recipe 10", image: "https://via.placeholder.com/1920x1080"),
        ],totalResults: 220)
        
        completion(.success(mockRecipes))
    }
}
