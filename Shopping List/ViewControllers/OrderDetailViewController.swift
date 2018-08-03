//
//  OrderDetailViewController.swift
//  Shopping List
//
//  Created by De MicheliStefano on 03.08.18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class OrderDetailViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    @IBAction func sendOrder(_ sender: Any) {
        
    }
    
    private func updateViews() {
        var shoppingListCount = 0
        if let shoppingList = shoppingItemController?.shoppingItems {
            shoppingListCount = shoppingList.filter( { $0.addedToShoppingList == true } ).count
        }
        descriptionTextLabel?.text = "You currently have \(shoppingListCount) item(s) in your shopping list"
    }
    
    // MARK: - Properties
    
    var shoppingItemController: ShoppingItemController?
    
    @IBOutlet weak var descriptionTextLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    

}
