//
//  NotificationWithDrawing.swift
//  BubblegumNotificationsSwift
//
//  Created by Martin Berger on 10/14/16.
//  Copyright © 2016 codecentric.de. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationWithDrawing: NotificationRequestProtocol {

    internal static let categoryIdentifier = "NotificationWithDrawing::CategoryIdentifier"
    internal static let requestIdentifier = "NotificationWithDrawing::RequestIdentifier"
    var category: UNNotificationCategory? = {
        let cool = UNNotificationAction.init(identifier: "NotificationWithDrawing::CoolAction", title: "Cool", options: [.foreground])
        let category = UNNotificationCategory.init(identifier: NotificationWithDrawing.categoryIdentifier, actions: [cool], intentIdentifiers: [], options: [])
        return category
    }()
    
    func request() -> UNNotificationRequest! {
        
        let content = UNMutableNotificationContent.init()
        content.title = "Drawing"
        content.body = "Swipe down to reveal"
        content.categoryIdentifier = NotificationWithDrawing.categoryIdentifier
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: NotificationServiceConstants.timeout, repeats: false)
        let request = UNNotificationRequest.init(identifier: NotificationWithDrawing.requestIdentifier, content: content, trigger: trigger)
        
        return request
    }
    
    func identifier() -> String! {
        return NotificationWithDrawing.requestIdentifier
    }
}
