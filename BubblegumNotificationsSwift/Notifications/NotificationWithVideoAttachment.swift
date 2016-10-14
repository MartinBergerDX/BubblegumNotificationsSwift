//
//  PlainNotification.swift
//  BubblegumNotificationsSwift
//
//  Created by Martin Berger on 10/10/16.
//  Copyright © 2016 codecentric.de. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationWithVideoAttachment: NotificationRequestProtocol {
    
    public static let requestIdentifier: String = "NotificationWithVideoAttachmentRequestIdentifier"
    
    func request() -> UNNotificationRequest! {
        guard let movie = movieAttachment() else {
            return nil
        }
        
        let content = UNMutableNotificationContent.init()
        content.title = "Video Attachment"
        content.body = "Swipe down to play video"
        content.attachments = [movie]
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: NotificationServiceConstants.timeout, repeats: false)
        let request = UNNotificationRequest.init(identifier: NotificationWithVideoAttachment.requestIdentifier, content: content, trigger: trigger)
        
        return request
    }
    
    internal func movieAttachment() -> UNNotificationAttachment? {
        let url: URL? = Bundle.main.url(forResource: "bigBuck", withExtension: "mp4")
        guard url != nil else {
            print("failed to obtain url for file")
            return nil
        }
        
        let attachment = try? UNNotificationAttachment.init(identifier: "plain", url: url!, options: [UNNotificationAttachmentOptionsTypeHintKey : "mp4"])
        guard attachment != nil else {
            print("failed to create notification attachment")
            return nil
        }
        
        return attachment
    }
    
    func identifier() -> String! {
        return NotificationWithVideoAttachment.requestIdentifier
    }
}
