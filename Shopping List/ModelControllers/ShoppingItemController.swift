//
//  ShoppingItemController.swift
//  Shopping List
//
//  Created by De MicheliStefano on 03.08.18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

let itemNames = ["apple", "grapes", "milk", "muffin", "popcorn", "soda", "strawberries"]

class ShoppingItemController {
    
    init () {
        if !shoppingListHasBeenInitialized {
            initializeShoppingItems(for: itemNames)
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: shoppingListInitializerKey)
            saveToPersistenceStore()
        }
        loadFromPersistenceStore()
    }
    
    // MARK: - Methods
    
    func addOrRemoveShoppingItem(shoppingItem: ShoppingItem) {
        guard let index = shoppingItems.index(of: shoppingItem) else { return }
        var item = shoppingItems[index]
        item.addedToShoppingList = !item.addedToShoppingList
        shoppingItems.remove(at: index)
        shoppingItems.insert(item, at: index)
        saveToPersistenceStore()
    }
    
    private func loadFromPersistenceStore() {
        let decoder = PropertyListDecoder()
        guard let shoppingListURL = shoppingListURL else { return }
        
        do {
            let data = try Data(contentsOf: shoppingListURL)
            shoppingItems = try decoder.decode([ShoppingItem].self, from: data)
        } catch {
            NSLog("Error has occured while loading shopping list: \(error)")
        }
    }
    
    private func saveToPersistenceStore() {
        let encoder = PropertyListEncoder()
        guard let shoppingListURL = shoppingListURL else { return }
        
        do {
            let encodedData = try encoder.encode(shoppingItems)
            try encodedData.write(to: shoppingListURL)
        } catch {
            NSLog("Error has occured while saving shopping list: \(error)")
        }
        
    }
    
    private func initializeShoppingItems(for items: [String]) {
        for item in items {
            let shoppingItem = ShoppingItem(name: item, image: item)
            shoppingItems.append(shoppingItem)
        }
        saveToPersistenceStore()
    }
    
    // MARK: - Properties
    
    var shoppingItems: [ShoppingItem] = []
    
    var shoppingListURL: URL? {
        let fm = FileManager.default
        let fileName = "shopping_list.plist"
        
        let documentsDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first
        return documentsDir?.appendingPathComponent(fileName)
    }
    
    let shoppingListInitializerKey: String = "ShoppingListInitializerKey"
    var shoppingListHasBeenInitialized: Bool {
        let userDefaults = UserDefaults.standard
        let shoppingListHasBeenInitialized = userDefaults.bool(forKey: shoppingListInitializerKey)
        if shoppingListHasBeenInitialized {
            return shoppingListHasBeenInitialized
        } else {
            return false
        }
    }
    
}
