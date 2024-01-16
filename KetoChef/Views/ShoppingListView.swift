//
//  ShoppingListView.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 16/01/2024.
//

import SwiftUI

struct ShoppingListView: View {
    @ObservedObject var viewModel: ShoppingListViewModel
    @State private var isTextFieldVisible = false
    @State private var textFieldText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.shoppingItems, id: \.name) { shoppingItem in
                        Text(shoppingItem.name)
                    }
                    .onDelete(perform: viewModel.deleteItem)
                }
                .navigationBarItems(trailing: Button {
                    isTextFieldVisible.toggle()
                    textFieldText = ""
                } label: {
                    Image(systemName: isTextFieldVisible ? "checkmark" : "plus")
                })
                .navigationTitle("Shopping List")
                
                if isTextFieldVisible {
                    TextField("Enter text", text: $textFieldText) {
                        viewModel.add(shoppingItem: ShoppingItem(name: textFieldText))
                        isTextFieldVisible = false
                    }
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .transition(.move(edge: .bottom))
                    .animation(.default)
                }
            }
        }
    }
}

#Preview {
    ShoppingListView(viewModel: ShoppingListViewModel())
}
