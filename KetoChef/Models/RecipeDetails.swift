//
//  RecipeDetails.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

struct RecipeDetails: Decodable {
    let id: Int
    let title: String
    let image: String
    let imageType: String
    let servings: Int
    let readyInMinutes: Int
    let healthScore: Double
    let spoonacularScore: Double
    let pricePerServing: Double
    let analyzedInstructions: [String] // Assuming instructions are provided as an array of strings
    let dishTypes: [String]
    let extendedIngredients: [Ingredient]
    let summary: String
    
    // Additional properties as needed
    
    struct Ingredient: Decodable {
        let aisle: String
        let amount: Double
        let consistency: String
        let id: Int
        let image: String
        let measures: Measures
        let meta: [String]
        let name: String
        let original: String
        let originalName: String
        let unit: String
        
        struct Measures: Decodable {
            let metric: Measure
            let us: Measure
            
            struct Measure: Decodable {
                let amount: Double
                let unitLong: String
                let unitShort: String
            }
        }
    }
}
