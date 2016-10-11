//
//  NotificationViewController.swift
//  BubblegumNotificationsContentExtension
//
//  Created by Martin Berger on 9/28/16.
//  Copyright © 2016 codecentric.de. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    @IBOutlet var contentImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentImageView?.layer.cornerRadius = 7.0
        self.contentImageView?.layer.masksToBounds = true
        
        let pathUrl = Bundle.main.url(forResource: "cubes", withExtension: "gif")
        let imageData = try? Data.init(contentsOf: pathUrl!)
        let image = UIImage.init(data: imageData!)
        self.contentImageView?.image = image
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
    }

}
