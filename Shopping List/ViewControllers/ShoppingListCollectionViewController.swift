//
//  ShoppingListCollectionViewController.swift
//  Shopping List
//
//  Created by De MicheliStefano on 03.08.18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit


class ShoppingListCollectionViewController: UICollectionViewController, ShoppingListCollectionViewCellDelegate {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    func addOrRemoveShoppingItems(for shoppingItem: ShoppingItem) {
        shoppingItemController.addOrRemoveShoppingItem(shoppingItem: shoppingItem)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowOrderDetail" {
            guard let vc = segue.destination as? OrderDetailViewController else { return }
            vc.shoppingItemController = shoppingItemController
        }
    }
    
    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shoppingItemController.shoppingItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingItemCell", for: indexPath)
    
        guard let shoppingItemCell = cell as? ShoppingListCollectionViewCell else { return cell }
        let shoppingItem = shoppingItemController.shoppingItems[indexPath.item]
        shoppingItemCell.shoppingItem = shoppingItem
        shoppingItemCell.shoppingItemController = shoppingItemController
        shoppingItemCell.delegate = self
        
        return shoppingItemCell
    }
  
    
    // MARK: - Properties
    
    var shoppingItemController = ShoppingItemController()
    
}
