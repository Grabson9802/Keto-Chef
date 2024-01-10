//
//  ContentView.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

import SwiftUI

struct RecipeView: View {
    @ObservedObject var viewModel: RecipeViewModel
    @State private var isPresented = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.recipes) { recipe in
                        RecipeItemView(recipe: recipe)
                            .onTapGesture {
                                isPresented.toggle()
                            }
                            .fullScreenCover(isPresented: $isPresented) {
                                RecipeDetailsView(recipeId: recipe.id, viewModel: viewModel)
                            }
                    }
                }
                .padding()
            }
            .navigationBarTitle("Keto Chef")
            .onAppear {
                viewModel.fetchRecipes()
            }
        }
    }
}

#Preview {
    RecipeView(viewModel: RecipeViewModel(recipeService: RecipeMockService()))
}
