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
        return NotificationWithVideoAttachment()
    }
    
    func withImageAttachment() -> NotificationRequestProtocol! {
        return NotificationWithImageAttachment()
    }
    
    func withMusicAttachment() -> NotificationRequestProtocol! {
        return NotificationWithMusicAttachment()
    }
    
    func withAnimation() -> NotificationRequestProtocol! {
        return NotificationWithAnimation()
    }
    
    func withDrawing() -> NotificationRequestProtocol! {
        return NotificationWithDrawing()
    }
}
