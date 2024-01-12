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
    @State private var isSummaryTextExpanded = false
    @State private var isLoading = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if let details = viewModel.selectedRecipeDetails {
                    if let url = URL(string: details.image) {
                        AsyncImageView(url: url)
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height / 2)
                            .clipped()
                            .edgesIgnoringSafeArea(.top)
                            .overlay(
                                LinearGradient(
                                    gradient: Gradient(colors: [.white, .clear]),
                                    startPoint: .bottom,
                                    endPoint: .center
                                )
                                .opacity(1)
                            )
                            .id(UUID())
                    }
                    
                    VStack {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(details.title)
                                    .font(.title)
                                    .bold()
                                
                                Text(details.summary.removeHTMLTagsAndBraces())
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
                                    TextEditor(text: .constant(details.summary))
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
                                        ForEach(details.extendedIngredients, id: \.id) { ingredient in
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
                        .padding()
                        
                        Button {
                            
                        } label: {
                            Text("Start Cooking")
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.yellow)
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .frame(height: geometry.size.height / 1.7)
                    .shadow(radius: 5)
                    .scrollIndicators(.hidden)
                    .offset(y: -geometry.size.height / 8)
                } else {
                    if isLoading {
                            ProgressView("Loading...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
            .onAppear {
                isLoading = true
                viewModel.fetchRecipeDetails(for: recipeId) {
                    isLoading = false
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
    RecipeDetailsView(recipeId: 0, viewModel: RecipeViewModel(recipeService: RecipeMockService()))
}
