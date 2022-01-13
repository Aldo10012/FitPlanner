//
//  NotificationManager.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/7/22.
//

import UserNotifications
import UIKit

class NotificationManager {
    
    /// id is name of workout + date "\(name)-\(date)" ~ "Push-12:10:2020"
    func setupLocalNotification(name: String, date: Date, id: String) {
        // Step 1: Ask for permission
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        }
        
        // Step 2: Create the notification content
        let content = UNMutableNotificationContent()
        content.title = name
        content.sound = .default
        content.body = "You have a workout today"
        
        // Step 3: Create the notification trigger
        let date = date
        let dateComponents = Calendar.current.dateComponents([.weekday], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Step 4: Create the request
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        // Step 5: Register the request
        center.add(request) { (error) in
            // Check the error parameter and handle any errors
        }
    }
    
    /// id is name of workout + date "\(name)-\(date)" ~ "Push-12:10:2020"
    func deleteNotification(withID id: String) {
        let center = UNUserNotificationCenter.current()
        
        center.removePendingNotificationRequests(withIdentifiers: [id])
    }
    
}



