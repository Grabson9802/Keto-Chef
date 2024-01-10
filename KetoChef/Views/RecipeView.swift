//
//  ContentView.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

import SwiftUI

struct RecipeView: View {
    @ObservedObject var viewModel: RecipeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.recipes) { recipe in
                        RecipeItemView(recipe: recipe)
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

struct RecipeItemView: View {
    let recipe: Recipe
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImageView(url: URL(string: recipe.image)!)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    Spacer()
                    Text(recipe.title)
                        .font(.title)
                        .lineLimit(2)
                        .padding(8)
                        .padding(.leading, 10)
                        .frame(width: geometry.size.width, alignment: .leading)
                        .background(
                            BlurView(style: .dark)
                        )
                        .foregroundColor(.white)
                }
            }
        }
        .cornerRadius(10)
    }
}

#Preview {
    RecipeView(viewModel: RecipeViewModel(recipeService: RecipeMockService()))
}
