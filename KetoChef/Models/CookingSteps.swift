//
//  CookingSteps.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 12/01/2024.
//

import Foundation

struct CookingSteps: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let steps: [Steps]
    
    struct Steps: Decodable, Identifiable {
        let id = UUID()
        let number: Int
        let step: String
        let ingredients: [Ingredients]
        
        struct Ingredients: Decodable, Identifiable {
            let id = UUID()
            let name: String
            let image: String
        }
    }
}

