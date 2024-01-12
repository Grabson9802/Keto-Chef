//
//  KetoChefApp.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

import SwiftUI

@main
struct KetoChefApp: App {
    
    var body: some Scene {
        WindowGroup {
            RecipeView(viewModel: RecipeViewModel(recipeService: RecipeAPIService()))
        }
    }
}
