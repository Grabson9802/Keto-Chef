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
    @Published var filteredRecipes: [Recipe] = []
    @Published var selectedRecipeDetails: RecipeDetails?
    @Published var searchQuery: String = "" {
        didSet {
            performSearch(with: searchQuery)
        }
    }
    
    init(recipeService: RecipeServiceProtocol = RecipeAPIService()) {
        self.recipeService = recipeService
        self.filteredRecipes = recipes
    }
    
    func performSearch(with query: String) {
        if query.isEmpty {
            filteredRecipes = recipes
        } else {
            filteredRecipes = recipes.filter {
                $0.title.localizedCaseInsensitiveContains(query)
            }
        }
    }
    
    func fetchRecipes() {
        recipeService.fetchRecipes { result in
            DispatchQueue.main.async {
                self.recipes = result ?? []
                self.filteredRecipes = self.recipes
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
