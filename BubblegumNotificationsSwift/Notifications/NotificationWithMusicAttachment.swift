//
//  PlainNotificationWithMusic.swift
//  BubblegumNotificationsSwift
//
//  Created by Martin Berger on 10/11/16.
//  Copyright © 2016 codecentric.de. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationWithMusicAttachment: NotificationRequestProtocol {
    
    public static let requestIdentifier: String = "NotificationWithMusicAttachmentRequestIdentifier"
    
    func request() -> UNNotificationRequest! {
        guard let music = musicAttachment() else {
            return nil
        }
        
        let content = UNMutableNotificationContent.init()
        content.title = "Music Attachment"
        content.body = "Swipe down to play music"
        content.attachments = [music]
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: NotificationServiceConstants.timeout, repeats: false)
        let request = UNNotificationRequest.init(identifier: NotificationWithMusicAttachment.requestIdentifier, content: content, trigger: trigger)
        
        return request
    }
    
    internal func musicAttachment() -> UNNotificationAttachment? {
        let url: URL? = Bundle.main.url(forResource: "miracle", withExtension: "mp3")
        guard url != nil else {
            print("failed to obtain url for file")
            return nil
        }
        
        let attachment = try? UNNotificationAttachment.init(identifier: "music", url: url!, options: [UNNotificationAttachmentOptionsTypeHintKey : "mp3"])
        guard attachment != nil else {
            print("failed to create notification attachment")
            return nil
        }
        
        return attachment
    }
    
    func identifier() -> String! {
        return NotificationWithMusicAttachment.requestIdentifier
    }
}
