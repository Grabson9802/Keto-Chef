//
//  CookingStepsView.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 12/01/2024.
//

import SwiftUI

struct CookingStepsView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: RecipeViewModel
    
    let recipeId: Int
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Cooking Steps")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    ForEach(viewModel.cookingSteps, id: \.name) { cookingStep in
                        
                        VStack(alignment: .leading) {
                            Text(cookingStep.name)
                                .font(.headline)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                        }
                        
                        ForEach(cookingStep.steps, id: \.step) { step in
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Step \(step.number)")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                }
                                
                                HStack {
                                    Text(step.step.removeAmpersandEncoding())
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.leading)
                                    
                                    Spacer()
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.gray.opacity(0.1))
                            )
                        }
                    }
                }
                .padding()
                .onAppear {
                    viewModel.fetchCookingSteps(for: recipeId)
                }
            }
        }
    }
}
