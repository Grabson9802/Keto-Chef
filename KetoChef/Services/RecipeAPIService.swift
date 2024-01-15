//
//  RecipeAPIService.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

import Foundation

class RecipeAPIService: RecipeServiceProtocol {
    static let shared = RecipeAPIService()
    
    private let apiKey = ConfigReader.readApiKey() ?? ""
    
    private init() {}
    
    private func makeRequest<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    func fetchRecipes(offset: Int = 0, completion: @escaping (Result<RecipeResponse, Error>) -> Void) {
        let url = "https://api.spoonacular.com/recipes/complexSearch?diet=ketogenic&sort=popularity&sortDirection=desc&offset=\(offset * 100)&number=100&apiKey=\(apiKey)"
        makeRequest(urlString: url, completion: completion)
    }
    
    func fetchRecipeDetails(for recipeId: Int, completion: @escaping (Result<RecipeDetails, Error>) -> Void) {
        let url = "https://api.spoonacular.com/recipes/\(recipeId)/information?&apiKey=\(apiKey)"
        makeRequest(urlString: url, completion: completion)
    }
    
    func fetchAnalyzedInstructions(for recipeId: Int, completion: @escaping (Result<[CookingSteps], Error>) -> Void) {
        let url = "https://api.spoonacular.com/recipes/\(recipeId)/analyzedInstructions?apiKey=\(apiKey)"
        makeRequest(urlString: url, completion: completion)
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
}
