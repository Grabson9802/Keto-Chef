//
//  ContentView.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

import SwiftUI

struct RecipeView: View {
    @ObservedObject var viewModel: RecipeViewModel
    @State private var selectedRecipe: Recipe?
    @State private var isSearching = false
    @State private var searchText = ""
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                if isSearching {
                    TextField("Search recipes...", text: $viewModel.searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
                VStack(spacing: 16) {
                    ForEach(viewModel.filteredRecipes) { recipe in
                        RecipeItemView(recipe: recipe)
                            .onTapGesture {
                                selectedRecipe = recipe
                            }
                            .fullScreenCover(item: $selectedRecipe) { recipe in
                                RecipeDetailsView(recipeId: recipe.id, viewModel: viewModel)
                            }
                    }
                }
                .padding()
                
                if isLoading {
                    VStack {
                        ProgressView("Loading...")
                            .padding(.top, UIScreen.main.bounds.height / 4)
                    }
                }
            }
            .navigationBarTitle("Keto Chef")
            .navigationBarItems(trailing:
                                    Button {
                withAnimation {
                    isSearching.toggle()
                    if !isSearching {
                        viewModel.performSearch(with: searchText)
                    } else {
                        viewModel.searchQuery = ""
                    }
                }
            } label: {
                Image(systemName: isSearching ? "xmark.circle.fill" : "magnifyingglass")
                    .frame(width: 36, height: 36)
                    .foregroundColor(.black)
                    .background(Color.black.opacity(0.15))
                    .cornerRadius(50)
            })
            .onAppear {
                isLoading = true
                viewModel.fetchRecipes {
                    isLoading = false
                }
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
