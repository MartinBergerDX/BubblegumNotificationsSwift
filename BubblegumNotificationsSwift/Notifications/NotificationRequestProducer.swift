//
//  NotificationRequestProducer.swift
//  BubblegumNotificationsSwift
//
//  Created by Martin Berger on 10/10/16.
//  Copyright © 2016 codecentric.de. All rights reserved.
//

import UIKit

class NotificationRequestProducer {
    
    func withVideoAttachment() -> NotificationRequestProtocol! {
        return PlainNotificationWithVideo()
    }
    
    func withImageAttachment() -> NotificationRequestProtocol! {
        return PlainNotificationWithImage()
    }
    
    func withMusicAttachment() -> NotificationRequestProtocol! {
        return PlainNotificationWithMusic()
    }
    
    func withAnimation() -> NotificationRequestProtocol! {
        return NotificationWithAnimation()
    }
}
