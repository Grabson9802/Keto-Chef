//
//  FavoritesView.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 14/01/2024.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: FavoritesViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.favoriteRecieps) { favoriteRecipe in
                    RecipeItemView(recipe: Recipe(id: favoriteRecipe.id, 
                                                  title: favoriteRecipe.title, image: favoriteRecipe.image))
                }
            }
            .padding(.horizontal)
            .onAppear {
                viewModel.getFavoriteRecipes()
            }
        }
    }
}

#Preview {
    FavoritesView(viewModel: FavoritesViewModel())
}
