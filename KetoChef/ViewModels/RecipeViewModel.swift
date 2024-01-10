//
//  RecipeViewModel.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

import SwiftUI

class RecipeViewModel: ObservableObject {
    private let recipeService: RecipeServiceProtocol
    
    @Published var recipes: [Recipe] = []
    @Published var selectedRecipeDetails: RecipeDetails?

    init(recipeService: RecipeServiceProtocol = RecipeAPIService()) {
        self.recipeService = recipeService
    }

    func fetchRecipes() {
        recipeService.fetchRecipes { result in
            DispatchQueue.main.async {
                self.recipes = result ?? []
            }
        }
    }
    
    func fetchRecipeDetails(for recipeId: Int) {
            recipeService.fetchRecipeDetails(for: recipeId) { result in
                DispatchQueue.main.async {
                    self.selectedRecipeDetails = result
                }
            }
        }
}
