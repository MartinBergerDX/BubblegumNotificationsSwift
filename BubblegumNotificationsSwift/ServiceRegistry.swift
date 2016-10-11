//
//  ServiceRegistry.swift
//  BubblegumNotificationsSwift
//
//  Created by Martin Berger on 10/10/16.
//  Copyright © 2016 codecentric.de. All rights reserved.
//

import UIKit

class ServiceRegistry: NSObject {
    static let shared = ServiceRegistry()
    lazy var notificationService = NotificationService()
}
