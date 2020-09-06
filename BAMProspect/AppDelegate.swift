//
//  AppDelegate.swift
//  BAMProspect
//
//  Created by Nicolas Masson on 06/09/2020.
//  Copyright © 2020 BAM. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let main = UIStoryboard(name: "Main", bundle: .main)
        let viewController = main.instantiateInitialViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }


}

