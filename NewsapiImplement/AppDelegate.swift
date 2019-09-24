//
//  AppDelegate.swift
//  NewsapiImplement
//
//  Created by Hung Nguyen Thanh on 9/23/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import UIKit
import SwiftyBeaver

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Setup logger
        configLog(configs: [ConsoleDestination()])

        return true
    }
}

