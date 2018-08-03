//
//  ShoppingListCollectionViewCell.swift
//  Shopping List
//
//  Created by De MicheliStefano on 03.08.18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ShoppingListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Methods
    
    private func updateViews() {
        guard let shoppingItem = shoppingItem else { return }
        nameTextLabel?.text = shoppingItem.name
        imageButton?.setImage(UIImage(data: shoppingItem.image), for: .normal)
    }
    
    // MARK: - Properties
    
    var shoppingItem: ShoppingItem? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var imageButton: UIButton!
    
}
