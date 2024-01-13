//
//  RecipeAPIService.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

import Foundation

class RecipeAPIService: RecipeServiceProtocol {
    func fetchRecipes(offset: Int = 0, completion: @escaping (RecipeResponse?) -> Void) {
        if let apiKey = ConfigReader.readApiKey() {
            guard let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch?diet=ketogenic&sort=popularity&sortDirection=desc&offset=\(offset * 100)&number=100&apiKey=\(apiKey)") else {
                print("Invalid URL")
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(RecipeResponse.self, from: data)
                        completion(result)
                    } catch {
                        print("Error from fetchRecipes decoding JSON: \(error)")
                    }
                }
            }
            
            task.resume()
        } else {
            print("The API key could not be read.")
        }
    }
    
    func fetchRecipeDetails(for recipeId: Int, completion: @escaping (RecipeDetails?) -> Void) {
        if let apiKey = ConfigReader.readApiKey() {
            guard let url = URL(string: "https://api.spoonacular.com/recipes/\(recipeId)/information?&apiKey=\(apiKey)") else {
                print("Invalid URL")
                completion(nil)
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    completion(nil)
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(RecipeDetails.self, from: data)
                        completion(result)
                    } catch {
                        print("Error from fetchRecipeDetails decoding JSON: \(error)")
                        completion(nil)
                    }
                }
            }
            
            task.resume()
        } else {
            print("The API key could not be read.")
        }
    }
    
    func fetchAnalyzedInstructions(for recipeId: Int, completion: @escaping ([CookingSteps]?) -> Void) {
        if let apiKey = ConfigReader.readApiKey() {
            guard let url = URL(string: "https://api.spoonacular.com/recipes/\(recipeId)/analyzedInstructions?apiKey=\(apiKey)") else {
                print("Invalid URL")
                completion(nil)
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    completion(nil)
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode([CookingSteps].self, from: data)
                        completion(result)
                    } catch {
                        print("Error from fetchRecipeDetails decoding JSON: \(error)")
                        completion(nil)
                    }
                }
            }
            
            task.resume()
        } else {
            print("The API key could not be read.")
        }
    }
}
