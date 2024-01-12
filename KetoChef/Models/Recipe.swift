//
//  Recipe.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

struct RecipeResponse: Decodable {
    let results: [Recipe]
}

struct Recipe: Identifiable, Decodable {
    let id: Int
    let title: String
    let image: String
}
