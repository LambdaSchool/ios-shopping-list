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
        self.collectionView?.reloadData()
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
            vc.localNotificationHelper = localNotificationHelper
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingItemCell", for: indexPath) as? ShoppingListCollectionViewCell else { fatalError("Error getting CollectionViewCell") }
    
        let shoppingItem = shoppingItemController.shoppingItems[indexPath.item]
        cell.shoppingItem = shoppingItem
        cell.shoppingItemController = shoppingItemController
        cell.delegate = self
        
        return cell
    }  
    
    // MARK: - Properties
    
    var shoppingItemController = ShoppingItemController()
    var localNotificationHelper = LocalNotificationHelper()
    
}
