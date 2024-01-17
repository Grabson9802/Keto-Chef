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
    @Published var cookingSteps: [CookingSteps] = []
    @Published var favoriteRecipesInDetails: [RecipeDetails] = []
    @Published var favoriteRecipes: [Recipe] = []
    @Published var searchQuery: String = "" {
        didSet {
            performSearch(with: searchQuery)
        }
    }
    
    init(recipeService: RecipeServiceProtocol = RecipeAPIService.shared) {
        self.recipeService = recipeService
        self.filteredRecipes = recipes
    }
    
    func getFavoriteRecipe(recipeId: Int, completion: @escaping (() -> Void)) {
        FavoritesManager.shared.getFavorite(recipeId: recipeId, completion: { favoriteRecip in
            self.selectedRecipeDetails = favoriteRecip
        })
    }
    
    func getFavoriteRecipes(completion: @escaping (() -> Void)) {
        favoriteRecipesInDetails = FavoritesManager.shared.getFavorites()
        var tempArr: [Recipe] = []
        favoriteRecipesInDetails.forEach { favoriteRecipe in
            tempArr.append(Recipe(id: favoriteRecipe.id, title: favoriteRecipe.title, image: favoriteRecipe.image))
        }
        favoriteRecipes = tempArr
        completion()
    }
    
    func fetchCookingSteps(for recipeId: Int, completion: (() -> Void)? = nil) {
        recipeService.fetchAnalyzedInstructions(for: recipeId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cookingSteps):
                    self.cookingSteps = cookingSteps
                case .failure(let error):
                    print("Error fetching cooking steps: \(error)")
                }
                completion?()
            }
        }
    }
    
    func fetchRecipeDetails(for recipeId: Int, completion: (() -> Void)? = nil) {
        recipeService.fetchRecipeDetails(for: recipeId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let selectedRecipeDetails):
                    self.selectedRecipeDetails = selectedRecipeDetails
                case .failure(let error):
                    print("Error fetching recipe details: \(error)")
                }
                completion?()
            }
        }
    }
    
    func fetchRecipes(offset: Int, sort: SortingOption, completion: @escaping (() -> Void)) {
        recipeService.fetchRecipes(offset: offset, sort: sort) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let recipes):
                    self.recipes = recipes.results
                    self.filteredRecipes = self.recipes
                    completion()
                case .failure(let error):
                    print("Error fetching recipes: \(error)")
                }
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
    
    func hasEnoughDataToChangePage() -> Bool {
        recipes.count == 100
    }
}

