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
    @Published var isLoading: Bool = false // Added loading state
    
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
    
    func fetchRecipes(completion: (() -> Void)? = nil) {
        isLoading = true // Set loading state to true
        recipeService.fetchRecipes { result in
            DispatchQueue.main.async {
                self.recipes = result?.results ?? []
                self.filteredRecipes = self.recipes
                self.isLoading = false // Set loading state to false when fetching is done
                completion?()
            }
        }
    }
    
    func fetchRecipeDetails(for recipeId: Int) {
        isLoading = true // Set loading state to true
        recipeService.fetchRecipeDetails(for: recipeId) { result in
            DispatchQueue.main.async {
                self.selectedRecipeDetails = result
                self.isLoading = false // Set loading state to false when fetching is done
            }
        }
    }
}

