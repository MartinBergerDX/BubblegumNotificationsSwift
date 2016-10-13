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
        ServiceRegistry.shared.notificationService.notificationWithVideoAttachment()
    }
    
    @IBAction func plainNotificationWithImage(sender: UIButton) {
        ServiceRegistry.shared.notificationService.notificationWithImageAttachment()
    }
    
    @IBAction func plainNotificationWithMusic(sender: UIButton) {
        ServiceRegistry.shared.notificationService.notificationWithMusicAttachment()
    }
    
    @IBAction func notificationWithAnimation(sender: UIButton) {
        ServiceRegistry.shared.notificationService.notificationWithAnimation()
    }
    
    internal func setButtons(toEnabled enabled: Bool) {
        self.buttonCollection.forEach { (button: UIButton) in
            button.isEnabled = enabled
        }
    }
}

