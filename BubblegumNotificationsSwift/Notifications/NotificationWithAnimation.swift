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
    
    internal static let categoryIdentifier = "NotificationWithAnimation::CategoryIdentifier"
    internal static let requestIdentifier = "NotificationWithAnimation::RequestIdentifier"
    var category: UNNotificationCategory? = {
        let cool = UNNotificationAction.init(identifier: "NotificationWithAnimation::CoolAction", title: "Cool", options: [.foreground])
        let approve = UNNotificationAction.init(identifier: "NotificationWithAnimation::ApproveAction", title: "Approve", options: [.foreground])
        let later = UNNotificationAction.init(identifier: "NotificationWithAnimation::LaterAction", title: "Later", options: [.foreground])
        let like = UNNotificationAction.init(identifier: "NotificationWithAnimation::LikeAction", title: "Like", options: [.foreground])
        let category = UNNotificationCategory.init(identifier: NotificationWithAnimation.categoryIdentifier, actions: [cool, approve, later, like], intentIdentifiers: [], options: [])
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
