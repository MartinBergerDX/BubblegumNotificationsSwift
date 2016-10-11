//
//  NotificationServiceConstants.swift
//  BubblegumNotificationsSwift
//
//  Created by Martin Berger on 10/10/16.
//  Copyright © 2016 codecentric.de. All rights reserved.
//

import UserNotifications

protocol NotificationRequestProtocol {
    func request() -> UNNotificationRequest!
    func identifier() -> String!
}

struct NotificationServiceConstants {
    static let timeout: Double = 2.0
    
    static let birthdayIdentifier: String = "bubblegumNotificationIdentifier"
    static let requestIdentifier: String = "bubblegumRequestNotificationIdentifier"
    static let emailAction: String = "birthdayEmailAction"
    static let smsAction: String = "birthdaySmsAction"
    
    static let plainNotificationRequestWithVideoIdentifier: String = "PlainNotificationRequestWithVideoIdentifier"
    static let plainNotificationRequestWithImageIdentifier: String = "PlainNotificationRequestWithImageIdentifier"
    static let plainNotificationRequestWithMusicIdentifier: String = "PlainNotificationRequestWithMusicIdentifier"
}
