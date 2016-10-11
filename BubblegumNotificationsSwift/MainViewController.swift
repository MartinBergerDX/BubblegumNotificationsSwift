//
//  ViewController.swift
//  BubblegumNotificationsSwift
//
//  Created by Martin Berger on 9/28/16.
//  Copyright © 2016 codecentric.de. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var buttonCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtons(toEnabled: false)
        ServiceRegistry.shared.notificationService.requestAuthorization(callback: { [unowned self] (granted: Bool) in
            if granted == true {
                DispatchQueue.main.async {
                    self.setButtons(toEnabled: true)
                }
            }
        })
    }
    
    @IBAction func plainNotificationWithVideo(sender: UIButton) {
        ServiceRegistry.shared.notificationService.addPlainWithVideo()
    }
    
    @IBAction func plainNotificationWithImage(sender: UIButton) {
        ServiceRegistry.shared.notificationService.addPlainWithImage()
    }
    
    @IBAction func plainNotificationWithMusic(sender: UIButton) {
        ServiceRegistry.shared.notificationService.addPlainWithMusic()
    }
    
    internal func setButtons(toEnabled enabled: Bool) {
        self.buttonCollection.forEach { (button: UIButton) in
            button.isEnabled = enabled
        }
    }
}

