//
//  ShoppingListItemsManager.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 16/01/2024.
//

import Foundation

class ShoppingItemsManager {
    static let shared = ShoppingItemsManager()
    
    private let shoppingItemsKey = "shoppingItems"
    private let userDefaults = UserDefaults.standard
    
    private init() {}
    
    func getShoppingItems() -> [ShoppingItem] {
        if let data = userDefaults.data(forKey: shoppingItemsKey) {
            do {
                let decoder = JSONDecoder()
                let shoppingItems = try decoder.decode([ShoppingItem].self, from: data)
                return shoppingItems
            } catch {
                print("Error decoding favorites: \(error)")
            }
        }
        return []
    }
    
    func saveShoppingItems(shoppingItems: [ShoppingItem]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(shoppingItems)
            userDefaults.set(data, forKey: shoppingItemsKey)
        } catch {
            print("Error encoding favorites: \(error)")
        }
    }
}
