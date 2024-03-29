//
//  RecipeDetailsView.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

import SwiftUI

struct RecipeDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: RecipeViewModel
    @State private var isSummaryTextExpanded = false
    @State private var isLoading = false
    @State private var isCookingStepsPresented = false
    @State private var isRecipeFavorite = false
    
    let recipeId: Int
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if let recipeDetails = viewModel.selectedRecipeDetails {
                    if let url = URL(string: recipeDetails.image) {
                        AsyncImageView(url: url)
                            .frame(width: geometry.size.width, height: geometry.size.height / 2)
                            .clipShape(BottomRoundedRect(radius: 20))
                            .shadow(radius: 5)
                            .edgesIgnoringSafeArea(.top)
                            .id(UUID())
                    }
                    
                    VStack {
                        ZStack(alignment: .top) {
                            HStack {
                                Spacer()
                                
                                Button {
                                    isRecipeFavorite.toggle()
                                    FavoritesManager.shared.toggleFavorite(recipeDetails)
                                    viewModel.getFavoriteRecipes() {
                                        
                                    }
                                } label: {
                                    Image(systemName: isRecipeFavorite ? "star.fill" : "star")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(isRecipeFavorite ? .yellow : .gray)
                                        .padding(8)
                                }
                                .background(
                                    Circle()
                                        .foregroundColor(.yellow.opacity(0.3))
                                        .frame(width: 80, height: 80)
                                        .offset(x: 15, y: -15)
                                )
                            }
                            
                            ScrollView(showsIndicators: false) {
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    Spacer()
                                    
                                    Text(recipeDetails.title)
                                        .font(.title)
                                        .bold()
                                    
                                    Text(recipeDetails.summary.removeHTMLTagsAndBraces())
                                        .foregroundColor(.secondary)
                                        .lineLimit(isSummaryTextExpanded ? nil : 3)
                                        .overlay(
                                            Text(isSummaryTextExpanded ? "less" : "more")
                                                .foregroundColor(.primary)
                                                .onTapGesture {
                                                    withAnimation {
                                                        isSummaryTextExpanded.toggle()
                                                    }
                                                }
                                                .padding(.bottom, -.infinity),
                                            alignment: .bottomTrailing
                                        )
                                        .onTapGesture {
                                            withAnimation {
                                                isSummaryTextExpanded.toggle()
                                            }
                                        }
                                    
                                    if isSummaryTextExpanded {
                                        TextEditor(text: .constant(recipeDetails.summary))
                                            .disabled(true)
                                            .opacity(0)
                                    }
                                    
                                    Spacer()
                                    
                                    Text("Ingredients")
                                        .font(.headline)
                                        .bold()
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(.gray.opacity(0.1))
                                        VStack(alignment: .leading, spacing: 10) {
                                            ForEach(recipeDetails.extendedIngredients, id: \.id) { ingredient in
                                                HStack {
                                                    Text("\(ingredient.name.capitalizingFirstLetter())")
                                                    
                                                    Spacer()
                                                    
                                                    Text("\(ingredient.amount.roundedWithoutZeros()) \(ingredient.measures.metric.unitLong)")
                                                }
                                            }
                                        }
                                        .padding()
                                    }
                                }
                            }
                            .frame(width: geometry.size.width - 80)
                            .cornerRadius(10)
                        }
                        
                        Button {
                            isCookingStepsPresented.toggle()
                        } label: {
                            Text("Start Cooking")
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.yellow)
                                .fullScreenCover(isPresented: $isCookingStepsPresented) {
                                    CookingStepsView(viewModel: viewModel, recipeId: recipeId)
                                }
                        }
                        .padding(.top, 8)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .frame(height: geometry.size.height / 1.5)
                    .offset(y: -150)
                    .shadow(radius: 5)
                } else {
                    if isLoading {
                        ProgressView("Loading...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
            .onAppear {
                isLoading = true
                isRecipeFavorite = FavoritesManager.shared.isFavorite(recipeId: recipeId)
                if !isRecipeFavorite {
                    viewModel.fetchRecipeDetails(for: recipeId) {
                        isLoading = false
                    }
                } else {
                    viewModel.getFavoriteRecipe(recipeId: recipeId) {
                        isLoading = false
                    }
                }
            }
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 20)
        }
    }
}


#Preview {
    RecipeDetailsView(viewModel: RecipeViewModel(recipeService: RecipeMockService.shared), recipeId: 0)
}
