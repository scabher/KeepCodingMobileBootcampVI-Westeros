//
//  AppDelegate.swift
//  Westeros
//
//  Created by Sergio Cabrera on 08/02/2018.
//  Copyright © 2018 Sergio Cabrera. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.backgroundColor = .cyan
        window?.makeKeyAndVisible()
        
        // Proxy para darle formato al navigation bar:
        // UINavigationBar.appearance().backgroundColor = .blue

        let  masterViewController = MasterViewController(
            houses: Repository.local.houses,
            seasons: Repository.local.seasons)

        // Creamos el view controller para pantalla partida
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [
                masterViewController.wrappedInNavigation(),
                masterViewController.houseDetailNavigationViewController
        ]

        // Asignamos el rootVC
        window?.rootViewController = splitViewController

        return true
    }
}

