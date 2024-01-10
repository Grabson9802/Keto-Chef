//
//  RecipeItemView.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

import SwiftUI

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
