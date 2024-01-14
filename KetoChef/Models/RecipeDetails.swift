//
//  RecipeDetails.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

struct RecipeDetails: Identifiable, Codable {
    let id: Int
    let title: String
    let image: String
    let summary: String
    let aggregateLikes: Int
    let extendedIngredients: [Ingredient]
    
    struct Ingredient: Codable {
        let id: Int
        let name: String
        let amount: Double
        let measures: Measures
        
        struct Measures: Codable {
            let metric: Metric
            
            struct Metric: Codable {
                let unitLong: String
            }
        }
    }
}
