//
//  Recipe.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

struct RecipeResponse: Codable {
    let results: [Recipe]
    let totalResults: Int
}

struct Recipe: Identifiable, Codable {
    let id: Int
    let title: String
    let image: String
}
