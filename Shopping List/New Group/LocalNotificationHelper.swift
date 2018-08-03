//
//  LocalNotificationHelper.swift
//  Shopping List
//
//  Created by De MicheliStefano on 03.08.18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationHelper
{
    func getAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            
            if let error = error { NSLog("Error requesting authorization status for local notifications: \(error)") }
            
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    func scheduleDailyReminderNotification(name: String, address: String)
    {
        let content = UNMutableNotificationContent()
        content.title = "Delivery for \(name.capitalized)"
        content.body = "Your shopping items will be delivered to \(address) in 15 minutes!"
        content.sound = UNNotificationSound.default()
        
        let notificationRequest = UNNotificationRequest(identifier: "delivery", content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false))
        
        let center = UNUserNotificationCenter.current()
        center.add(notificationRequest) { (error) in
            if let error = error
            {
                NSLog("There was an error scheduling a notification: \(error)")
            }
        }
    }
    
    
}
