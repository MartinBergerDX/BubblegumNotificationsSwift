//
//  AppDelegate.swift
//  BubblegumNotificationsSwift
//
//  Created by Martin Berger on 9/28/16.
//  Copyright © 2016 codecentric.de. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        ServiceRegistry.shared.notificationService.setup()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

