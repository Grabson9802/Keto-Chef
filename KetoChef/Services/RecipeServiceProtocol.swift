//
//  RecipeServiceProtocol.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

protocol RecipeServiceProtocol {
    func fetchRecipes(offset: Int, completion: @escaping (RecipeResponse?) -> Void)
    func fetchRecipeDetails(for recipeId: Int, completion: @escaping (RecipeDetails?) -> Void)
    func fetchAnalyzedInstructions(for recipeId: Int, completion: @escaping ([CookingSteps]?) -> Void)
}
