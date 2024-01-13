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
    @State private var currentPage: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Keto Chef")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
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
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
            
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
                                RecipeDetailsView(viewModel: viewModel, recipeId: recipe.id)
                            }
                    }
                }
                .padding()
                
                Spacer()
                
                HStack {
                    Button {
                        if currentPage > 0 {
                            currentPage -= 1
                        }
                        viewModel.fetchRecipes(offset: currentPage)
                    } label: {
                        Image(systemName: "chevron.left")
                            .padding()
                            .foregroundColor(currentPage == 0 ? .gray : .black)
                    }
                    
                    Text("Page \(currentPage + 1)")
                    
                    Button {
                        if viewModel.hasEnoughData() {
                            currentPage += 1
                            viewModel.fetchRecipes(offset: currentPage)
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                            .padding()
                            .foregroundColor(viewModel.hasEnoughData() ? .black : .gray)
                    }
                }
                
                if isLoading {
                    VStack {
                        ProgressView("Loading...")
                            .padding(.top, UIScreen.main.bounds.height / 4)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .onAppear {
                isLoading = true
                viewModel.fetchRecipes(offset: currentPage) {
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
                        .font(.headline)
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
