//
//  CookingSteps.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 12/01/2024.
//

import Foundation

struct CookingSteps: Codable {
    let name: String
    let steps: [Steps]
}

struct Steps: Codable {
    let number: Int
    let step: String
    let ingredients: [Ingredients]
}

struct Ingredients: Identifiable, Codable {
    var id: Int
    let name: String
    let image: String
}
