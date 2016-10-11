//
//  NotificationRequestProducer.swift
//  BubblegumNotificationsSwift
//
//  Created by Martin Berger on 10/10/16.
//  Copyright © 2016 codecentric.de. All rights reserved.
//

import UIKit

class NotificationRequestProducer {
    
    func plainWithVideoAttachment() -> NotificationRequestProtocol! {
        return PlainNotificationWithVideo()
    }
    
    func plainWithImageAttachment() -> NotificationRequestProtocol! {
        return PlainNotificationWithImage()
    }
    
    func plainWithMusicAttachment() -> NotificationRequestProtocol! {
        return PlainNotificationWithMusic()
    }
}
