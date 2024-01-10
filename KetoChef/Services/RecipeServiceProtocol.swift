//
//  RecipeServiceProtocol.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

protocol RecipeServiceProtocol {
    func fetchRecipes(completion: @escaping ([Recipe]?) -> Void)
    func fetchRecipeDetails(for recipeId: Int, completion: @escaping (RecipeDetails?) -> Void)
}
