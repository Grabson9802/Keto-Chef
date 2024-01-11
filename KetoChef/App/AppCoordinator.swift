//
//  AppCoordinator.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var currentView: AnyView

    init() {
        let recipeViewModel = RecipeViewModel(recipeService: RecipeAPIService())
        let recipeView = RecipeView(viewModel: recipeViewModel)
        currentView = AnyView(recipeView)
    }
}
