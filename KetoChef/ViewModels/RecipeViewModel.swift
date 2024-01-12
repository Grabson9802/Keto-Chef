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
    @Published var isLoading: Bool = false
    @Published var cookingSteps: [CookingSteps] = []
    
    init(recipeService: RecipeServiceProtocol = RecipeAPIService()) {
        self.recipeService = recipeService
        self.filteredRecipes = recipes
    }
    
    func fetchCookingSteps(for recipeId: Int, completion: (() -> Void)? = nil) {
        recipeService.fetchAnalyzedInstructions(for: recipeId) { cookingSteps in
            DispatchQueue.main.async {
                self.cookingSteps = cookingSteps ?? []
                completion?()
            }
        }
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
    
    func fetchRecipes(completion: (() -> Void)? = nil) {
        isLoading = true
        recipeService.fetchRecipes { response in
            DispatchQueue.main.async {
                self.recipes = response?.results ?? []
                self.filteredRecipes = self.recipes
                self.isLoading = false
                completion?()
            }
        }
    }
    
    func fetchRecipeDetails(for recipeId: Int, completion: (() -> Void)? = nil) {
        recipeService.fetchRecipeDetails(for: recipeId) { result in
            DispatchQueue.main.async {
                self.selectedRecipeDetails = result
                completion?()
            }
        }
    }
}

