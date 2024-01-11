//
//  RecipeDetails.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

struct RecipeDetails: Identifiable, Decodable {
    let id: Int
    let title: String
    let image: String
    let summary: String
    let extendedIngredients: [Ingredient]
    let analyzedInstructions: [AnalyzedInstruction]

    struct AnalyzedInstruction: Decodable {
        let steps: [Step]
        
        struct Step: Decodable {
            let number: Int
            let step: String
        }
    }
}

struct Ingredient: Identifiable, Decodable {
    let id: Int
    let name: String
    let amount: Double
    let measures: Measures

    struct Measures: Decodable {
        let metric: Metric

        struct Metric: Decodable {
            let unitLong: String
        }
    }
}