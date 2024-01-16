//
//  ShoppingListViewModel.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 16/01/2024.
//

import SwiftUI

class ShoppingListViewModel: ObservableObject {
    @Published var shoppingItems: [ShoppingItem] = []
    
    init() {
        shoppingItems = ShoppingItemsManager.shared.getShoppingItems()
    }
    
    func add(shoppingItem: ShoppingItem) {
        shoppingItems.append(shoppingItem)
        saveChanges()
    }
    
    func deleteItem(at offsets: IndexSet) {
        shoppingItems.remove(atOffsets: offsets)
        saveChanges()
    }
    
    func saveChanges() {
        ShoppingItemsManager.shared.saveShoppingItems(shoppingItems: shoppingItems)
    }
}
