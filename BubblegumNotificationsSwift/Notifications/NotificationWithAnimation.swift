//
//  NotificationWithAnimation.swift
//  BubblegumNotificationsSwift
//
//  Created by Martin Berger on 10/13/16.
//  Copyright © 2016 codecentric.de. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationWithAnimation: NotificationRequestProtocol {
    
    public static let categoryIdentifier = "NotificationWithAnimation::CategoryIdentifier"
    public static let requestIdentifier = "NotificationWithAnimation::RequestIdentifier"
    var category: UNNotificationCategory? = {
        let cool = UNNotificationAction.init(identifier: "NotificationWithAnimation::CoolAction", title: "Cool", options: [.foreground])
        let category = UNNotificationCategory.init(identifier: NotificationWithAnimation.categoryIdentifier, actions: [cool], intentIdentifiers: [], options: [])
        return category
    }()
    
    func request() -> UNNotificationRequest! {
        
        let content = UNMutableNotificationContent.init()
        content.title = "Animation"
        content.body = "Swipe down to reveal"
        content.categoryIdentifier = NotificationWithAnimation.categoryIdentifier
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: NotificationServiceConstants.timeout, repeats: false)
        let request = UNNotificationRequest.init(identifier: NotificationWithAnimation.requestIdentifier, content: content, trigger: trigger)
        
        return request
    }
    
    func identifier() -> String! {
        return NotificationWithAnimation.requestIdentifier
    }
}
