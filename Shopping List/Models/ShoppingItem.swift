//
//  ShoppingItem.swift
//  Shopping List
//
//  Created by De MicheliStefano on 03.08.18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation
import UIKit

struct ShoppingItem: Equatable, Codable {
    
    init(name: String, image: String, addedToShoppingList: Bool = false) {
        self.name = name
        self.image = UIImagePNGRepresentation(UIImage(named: image)!)!
        self.addedToShoppingList = addedToShoppingList
    }
    
    var name: String
    var image: Data
    var addedToShoppingList: Bool
    
}
