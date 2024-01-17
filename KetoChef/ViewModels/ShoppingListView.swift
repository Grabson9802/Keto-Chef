//
//  ShoppingListView.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 16/01/2024.
//

import SwiftUI

struct ShoppingListView: View {
    @ObservedObject var viewModel: ShoppingListViewModel
    @State private var textFieldText = ""
    @State private var isEditing = false
    
    var body: some View {
            VStack {
                HStack {
                    Text("Shopping List")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                        if viewModel.shoppingItems.count > 0 {
                            isEditing.toggle()
                        }
                    } label: {
                        Image(systemName: isEditing ? "checkmark" : "square.and.pencil")
                                .resizable()
                    }
                    .frame(width: 26, height: 26)
                    .foregroundColor(.black)
                }
                .padding()
                
                TextField("Enter ingredient name", text: $textFieldText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Add to List") {
                    viewModel.add(shoppingItem: ShoppingItem(name: textFieldText))
                    textFieldText = ""
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("To buy:")
                            .font(.headline)
                        Spacer()
                    }
                    
                    ForEach(viewModel.shoppingItems.indices, id: \.self) { index in
                        HStack {
                            Text("• \(viewModel.shoppingItems[index].name)")
                            
                            Spacer()
                            
                            if isEditing {
                                Button(action: {
                                    viewModel.deleteItem(with: viewModel.shoppingItems[index].name)
                                    
                                    if viewModel.shoppingItems.count == 0 {
                                        isEditing = false
                                    }
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding()
                
                Spacer()
            }
    }
}

#Preview {
    ShoppingListView(viewModel: ShoppingListViewModel())
}
