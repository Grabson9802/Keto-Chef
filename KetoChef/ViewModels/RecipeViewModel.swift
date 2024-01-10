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
}
