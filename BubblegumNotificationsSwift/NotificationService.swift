//
//  NotificationService.swift
//  BubblegumNotificationsSwift
//
//  Created by Martin Berger on 8/29/16.
//  Copyright © 2016 Martin Berger. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

protocol NotificationServiceProtocol {
    func setup()
}

class NotificationService: NSObject, NotificationServiceProtocol {
    
    var authorized: Bool = false
    let producer = NotificationRequestProducer()
    var current: NotificationRequestProtocol?
    
    lazy private var bubblegumCategory: UNNotificationCategory? = {
        let checkAction = UNNotificationAction.init(identifier: NotificationServiceConstants.emailAction, title: "Check Offer", options: [.foreground])
        let nextTimeAction = UNNotificationAction.init(identifier: NotificationServiceConstants.smsAction, title: "Next Time", options: [.foreground])
        let bubblegumCategory = UNNotificationCategory.init(identifier: NotificationServiceConstants.birthdayIdentifier, actions: [checkAction, nextTimeAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([bubblegumCategory])
        return bubblegumCategory
    }()
    
    func setup() {
        // you must set the value of this property before your app finishes launching.
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().setNotificationCategories([NotificationWithAnimation().category!])
    }
    
    func requestAuthorization(callback: ((Bool) -> Void)?) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert]) { [unowned self] (granted, error) in
            self.authorized = granted
            if error != nil {
                print(error?.localizedDescription as String!)
            }
            
            if callback != nil {
                callback!(granted)
            }
        }
    }
    
    func scheduleNotification() {
        let body: String? = "Cheap bubblegums! Only Today!"
        
        // we must configure content first
        let content = UNMutableNotificationContent.init()
        content.title = "Huge Discount!"
        content.body = body!
        content.categoryIdentifier = NotificationServiceConstants.birthdayIdentifier
        
        // trigger is needed for system to know when to fire notification
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: NotificationServiceConstants.timeout, repeats: false)
        
        // ask to show our notification
        // be careful about request identifier, this uniquely identifies our notification
        // if we schedule several notfications with same identifier, only the last one will be scheduled
        let request = UNNotificationRequest.init(identifier: NotificationServiceConstants.requestIdentifier, content: content, trigger: trigger)

        schedule(request: request)
    }
    
    func notificationWithVideoAttachment() {
        self.current = producer.withVideoAttachment()
        schedule(request: self.current?.request()!)
    }
    
    func notificationWithImageAttachment() {
        self.current = producer.withImageAttachment()
        schedule(request: self.current?.request()!)
    }
    
    func notificationWithMusicAttachment() {
        self.current = producer.withMusicAttachment()
        schedule(request: self.current?.request()!)
    }
    
    func notificationWithAnimation() {
        self.current = producer.withAnimation()
        schedule(request: self.current?.request()!)
    }
    
    internal func schedule(request: UNNotificationRequest!) {
        if self.current != nil {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [self.current?.identifier() as String!])
            self.current = nil
        }
        UNUserNotificationCenter.current().add(request) { (error: Error?) in
            if error != nil {
                print(error?.localizedDescription as String!)
            }
        }
    }
    
    internal func check() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings: UNNotificationSettings) in
            self.authorized = (settings.authorizationStatus == .authorized)
        }
    }
    
    internal func showAlertOnReceivedNotification() {
        let controller = UIAlertController(title: "Alert", message: "You just got notified", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        controller.addAction(okAction)
        TopViewController.topViewController?.present(controller, animated: true, completion: nil)
    }
}

extension NotificationService: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
        completionHandler([.alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
        completionHandler()
    }
}
