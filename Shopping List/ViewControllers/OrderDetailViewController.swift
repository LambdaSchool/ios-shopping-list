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
        let notificationCenter = UNUserNotificationCenter.current()

        notificationCenter.getNotificationSettings() { (settings) in
            guard settings.authorizationStatus == .authorized else { return }
            if settings.alertSetting == .enabled {
                self.scheduleNotification()
            }
            else {
                self.requestNotificationsAuthorization()
            }
        }
    }
    
    // MARK: - NotificationHandlers
    
    private func scheduleNotification() {
        let content = UNMutableNotificationContent()
        guard let name = nameTextField?.text,
            let address = addressTextField?.text else { return }
        
        content.title = "Delivery for \(name)"
        content.body = "Your shopping items will be delivered to \(address) in 15 minutes"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 900, repeats: false)
        
        let request = UNNotificationRequest(identifier: "NotificationID", content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if let error = error {
                NSLog("There was an error scheduling a notification: \(error)")
                return
            }
            
        }
    }
    
    private func requestNotificationsAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if let error = error {
                NSLog("There was an error requesting authorization for notifications \(error)")
                return
            }
            
            NSLog("Notification authorization required? \(granted)")
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
        return
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
