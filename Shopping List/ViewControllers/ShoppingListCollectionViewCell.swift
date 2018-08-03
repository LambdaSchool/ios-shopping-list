//
//  ShoppingListCollectionViewCell.swift
//  Shopping List
//
//  Created by De MicheliStefano on 03.08.18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

protocol ShoppingListCollectionViewCellDelegate {
    func addOrRemoveShoppingItems(for shoppingItem: ShoppingItem)
}

class ShoppingListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Methods
    
    @IBAction func addOrRemove(_ sender: Any) {
        guard let shoppingItem = shoppingItem else { return }
        delegate?.addOrRemoveShoppingItems(for: shoppingItem)
    }
    
    private func updateViews() {
        guard let shoppingItem = shoppingItem else { return }
        hasBeenAddedTextLabel?.text = shoppingItem.addedToShoppingList ? "Added" : "Not Added"
        nameTextLabel?.text = shoppingItem.name
        imageButton?.setImage(UIImage(data: shoppingItem.image), for: .normal)
    }
    
    // MARK: - Properties
    
    var shoppingItem: ShoppingItem? {
        didSet {
            updateViews()
        }
    }
    var shoppingItemController: ShoppingItemController?
    var delegate: ShoppingListCollectionViewController?
    
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var hasBeenAddedTextLabel: UILabel!
    
}
