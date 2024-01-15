//
//  FavoritesView.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 14/01/2024.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: RecipeViewModel
    @State private var selectedFavoriteReciep: RecipeDetails?
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.favoriteRecipes) { favoriteRecipe in
                    let recipe = Recipe(id: favoriteRecipe.id, title: favoriteRecipe.title, image: favoriteRecipe.image)
                    RecipeItemView(recipe: recipe)
                        .onTapGesture {
                            selectedFavoriteReciep = favoriteRecipe
                        }
                        .fullScreenCover(item: $selectedFavoriteReciep) { favoriteRecipe in
                            RecipeDetailsView(viewModel: viewModel, recipeId: favoriteRecipe.id)
                        }
                }
            }
            .padding(.horizontal)
            .onAppear {
                viewModel.getFavoriteRecipes()
            }
        }
    }
}
