//
//  RecipeServiceProtocol.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

protocol RecipeServiceProtocol {
    func fetchRecipes(offset: Int, completion: @escaping (Result<RecipeResponse, Error>) -> Void)
    func fetchRecipeDetails(for recipeId: Int, completion: @escaping (Result<RecipeDetails, Error>) -> Void)
    func fetchAnalyzedInstructions(for recipeId: Int, completion: @escaping (Result<[CookingSteps], Error>) -> Void)
}
