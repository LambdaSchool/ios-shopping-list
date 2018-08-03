//
//  OrderDetailViewController.swift
//  Shopping List
//
//  Created by De MicheliStefano on 03.08.18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit
import UserNotifications

class OrderDetailViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    @IBAction func sendOrder(_ sender: Any) {
        guard let localNotificationHelper = localNotificationHelper else { return }
        localNotificationHelper.getAuthorizationStatus(completion: { (status) in
            if status != .authorized {
                self.requestNotificationAuthorization()
            } else if status == .authorized {
                guard let name = self.nameTextField.text,
                    let address = self.addressTextField.text else { return }
                self.localNotificationHelper?.scheduleDailyReminderNotification(name: name, address: address)
            }
        })
    }
    
    private func requestNotificationAuthorization() {
        self.localNotificationHelper?.requestAuthorization(completion: { (success) in
            if success {
                guard let name = self.nameTextField.text,
                    let address = self.addressTextField.text else { return }
                self.localNotificationHelper?.scheduleDailyReminderNotification(name: name, address: address)
            }
        })
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
    var localNotificationHelper: LocalNotificationHelper?
    
    @IBOutlet weak var descriptionTextLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    

}
