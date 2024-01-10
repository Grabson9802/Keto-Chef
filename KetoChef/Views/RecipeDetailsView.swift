//
//  RecipeDetailsView.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

import SwiftUI

struct RecipeDetailsView: View {
    @Environment(\.dismiss) var dismiss
    let recipeId: Int
    @ObservedObject var viewModel: RecipeViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if let details = viewModel.selectedRecipeDetails {
                    if let url = URL(string: details.image) {
                        AsyncImageView(url: url)
                            .scaledToFit()
                            .frame(width: geometry.size.width, height: geometry.size.height / 2)
                            .edgesIgnoringSafeArea(.top)
                            .background(Color.black)
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text(details.title)
                            .font(.title)
                            .bold()
                        
                        Text(details.summary)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                        
                        Text("Ingredients")
                            .font(.headline)
                            .bold()
                        ForEach(details.extendedIngredients, id: \.id) { ingredient in
                            HStack {
                                Text("\(ingredient.name)")
                                
                                Spacer()
                                
                                Text("\(ingredient.amount) \(ingredient.measures.metric.unitLong)")
                            }
                            .padding(.horizontal, 8)
                        }
                        
                        Button {
                            
                        } label: {
                            Text("Start Cooking")
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.yellow)
                                .cornerRadius(8)
                        }
                        
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .frame(width: geometry.size.width - 40)
                    .offset(y: -60)
                } else {
                    Text("Loading")
                }
            }
            .onAppear {
                viewModel.fetchRecipeDetails(for: recipeId)
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
            .offset(x: -20)
        }
    }
}


#Preview {
    RecipeDetailsView(recipeId: 0, viewModel: RecipeViewModel(recipeService: RecipeMockService()))
}
