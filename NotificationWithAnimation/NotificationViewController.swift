//
//  NotificationViewController.swift
//  NotificationWithAnimation
//
//  Created by Martin Berger on 10/13/16.
//  Copyright © 2016 codecentric.de. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
    }

}
