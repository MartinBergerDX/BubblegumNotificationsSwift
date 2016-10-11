//
//  TopViewController.swift
//  BubblegumNotificationsSwift
//
//  Created by Martin Berger on 10/10/16.
//  Copyright © 2016 codecentric.de. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {
    static var topViewController: UIViewController? {
        get {
            return TopViewController.findTopViewController()
        }
        set {
        }
    }
    
    private static func findTopViewController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedController = topController.presentedViewController {
                topController = presentedController
            }
            return topController
        }
        return nil
    }
}
