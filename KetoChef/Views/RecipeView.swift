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
    @State private var currentPage: Int = 0
    @State private var selectedSortingOption: SortingOption = .popularity
    @State private var showSortOptions = false
    @State private var isDataLoaded = false
    
    let onFavoritesView: Bool
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    Spacer()
                    HStack {
                        Text(onFavoritesView ? "Favorite Recipes" : "Keto Chef")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        if !onFavoritesView {
                            HStack {
                                Button {
                                    showSortOptions.toggle()
                                } label: {
                                    Image(systemName: "line.3.horizontal")
                                        .frame(width: 36, height: 36)
                                        .foregroundColor(.black)
                                        .background(Color.black.opacity(0.15))
                                        .cornerRadius(50)
                                }
                                .actionSheet(isPresented: $showSortOptions) {
                                    ActionSheet(title: Text("Sort by"), buttons: SortingOption.allCases.map { option in
                                        ActionSheet.Button.default(Text(option.rawValue.capitalizingFirstLetter())) {
                                            if selectedSortingOption != option {
                                                selectedSortingOption = option
                                                viewModel.fetchRecipes(offset: currentPage, sort: selectedSortingOption) {
                                                    isDataLoaded = true
                                                }
                                            }
                                        }
                                    } + [.cancel()]
                                    )
                                }
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
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                    
                    ScrollView(showsIndicators: false) {
                        if isSearching {
                            TextField("Search recipes...", text: $viewModel.searchQuery)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                        }
                        
                        VStack(spacing: 16) {
                            ForEach(onFavoritesView ? viewModel.favoriteRecipes : viewModel.filteredRecipes) { recipe in
                                RecipeItemView(recipe: recipe)
                                    .frame(maxHeight: geometry.size.width / 2)
                                    .onTapGesture {
                                        selectedRecipe = recipe
                                    }
                                    .fullScreenCover(item: $selectedRecipe) { recipe in
                                        RecipeDetailsView(viewModel: viewModel, recipeId: recipe.id)
                                    }
                            }
                        }
                        .padding()
                        
                        if isDataLoaded {
                            HStack {
                                Button {
                                    if currentPage > 0 && !onFavoritesView {
                                        currentPage -= 1
                                        viewModel.fetchRecipes(offset: currentPage, sort: selectedSortingOption) {
                                            isDataLoaded = true
                                        }
                                    }
                                } label: {
                                    Image(systemName: "chevron.left")
                                        .padding()
                                        .foregroundColor(currentPage == 0 ? .gray : .black)
                                }
                                
                                Text("Page \(currentPage + 1)")
                                
                                Button {
                                    if !onFavoritesView && viewModel.hasEnoughDataToChangePage() {
                                        currentPage += 1
                                        viewModel.fetchRecipes(offset: currentPage, sort: selectedSortingOption) {
                                            isDataLoaded = true
                                        }
                                    }
                                } label: {
                                    Image(systemName: "chevron.right")
                                        .padding()
                                        .foregroundColor(viewModel.hasEnoughDataToChangePage() ? .black : .gray)
                                }
                            }
                        } else {
                            ProgressView("Loading...")
                        }
                    }
                    .onAppear {
                        if onFavoritesView {
                            viewModel.getFavoriteRecipes() {
                                isDataLoaded = true
                            }
                        }
                        if viewModel.recipes.isEmpty {
                            viewModel.fetchRecipes(offset: currentPage, sort: selectedSortingOption) {
                                isDataLoaded = true
                            }
                        }
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 50, style: .continuous)
                        .foregroundColor(.yellow)
                        .frame(width: 400, height: 300)
                        .offset(y: -300)
                )
            }
        }
    }
}

struct RecipeItemView: View {
    let recipe: Recipe
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let url = URL(string: recipe.image) {
                AsyncImageView(url: url)
                
                GeometryReader { geometry in
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(recipe.title)
                            .font(.headline)
                            .fontWeight(.bold)
                            .lineLimit(2)
                            .padding(8)
                            .padding(.leading, 10)
                            .frame(width: geometry.size.width, alignment: .leading)
                            .background(
                                BlurView(style: .systemUltraThinMaterialDark)
                            )
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .cornerRadius(10)
    }
}

#Preview {
    RecipeView(viewModel: RecipeViewModel(recipeService: RecipeMockService.shared), onFavoritesView: false)
}
