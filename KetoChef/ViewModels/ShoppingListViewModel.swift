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
        getShoppingItems()
    }
    
    func add(shoppingItem: ShoppingItem) {
        shoppingItems.append(shoppingItem)
        saveChanges()
    }
    
    func deleteItem(with id: String) {
        shoppingItems.removeAll(where: {$0.name == id})
        saveChanges()
    }
    
    func saveChanges() {
        ShoppingItemsManager.shared.saveShoppingItems(shoppingItems: shoppingItems)
    }
    
    func getShoppingItems() {
        shoppingItems = ShoppingItemsManager.shared.getShoppingItems()
    }
}
