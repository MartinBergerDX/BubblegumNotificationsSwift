//
//  PlainNotificationWithImage.swift
//  BubblegumNotificationsSwift
//
//  Created by Martin Berger on 10/10/16.
//  Copyright © 2016 codecentric.de. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationWithImageAttachment: NotificationRequestProtocol {
    
    public static let requestIdentifier: String = "NotificationWithImageAttachmentRequestIdentifier"
    
    func request() -> UNNotificationRequest! {
        guard let image = imageAttachment() else {
            return nil
        }
        
        let content = UNMutableNotificationContent.init()
        content.title = "Image Attachment"
        content.body = "Swipe down to view image"
        content.attachments = [image]
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: NotificationServiceConstants.timeout, repeats: false)
        let request = UNNotificationRequest.init(identifier: NotificationWithImageAttachment.requestIdentifier, content: content, trigger: trigger)
        
        return request
    }
    
    internal func imageAttachment() -> UNNotificationAttachment? {
        let url: URL? = Bundle.main.url(forResource: "fatRabbit", withExtension: "png")
        guard url != nil else {
            print("failed to obtain url for file")
            return nil
        }
        
        let attachment = try? UNNotificationAttachment.init(identifier: "image", url: url!, options: [UNNotificationAttachmentOptionsTypeHintKey : "png"])
        guard attachment != nil else {
            print("failed to create notification attachment")
            return nil
        }
        
        return attachment
    }
    
    func identifier() -> String! {
        return NotificationWithImageAttachment.requestIdentifier
    }
}
