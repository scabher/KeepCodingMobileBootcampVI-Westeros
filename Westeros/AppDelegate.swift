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
        
        
        // Crear los modelos
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons

        // Vista inicial de Tabla
        // Creamos la tabla
        // let houseListViewController = HouseListViewController(model: houses)
        
     
        // Creamos los controladores (masterVC, detailVC)
        let houseListViewController = HouseListViewController(houses: houses)
        let seasonListViewController = SeasonListViewController(seasons: seasons)
        
        // Se obtiene la última fila seleccionada
        let lastSelectedHouse = houseListViewController.lastSelectedHouse()
        let houseDetailViewController = HouseDetailViewController(house: lastSelectedHouse)
        
        let lastSelectedSeason = seasonListViewController.lastSelectedSeason()
        let seasonDetailViewController = SeasonDetailViewController(season: lastSelectedSeason)
        
        // Asignamos el delegado de la lista que será el del detalle porque
        // es quien va a gestionar el cambio de casa en la lista (el que lo implementa)
        houseListViewController.delegate = houseDetailViewController
        seasonListViewController.delegate = seasonDetailViewController
        
        // Vista lateral izquierda
        // Creamos los combinadores para mostrar las casas como tabs
        let  tabBarViewController = UITabBarController()
        
        tabBarViewController.viewControllers = [houseListViewController, seasonListViewController]
        tabBarViewController.selectedViewController = tabBarViewController.viewControllers![1]
        
        // Creamos el view controller para pantalla partida
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [
                tabBarViewController.wrappedInNavigation(),
                seasonDetailViewController.wrappedInNavigation()
        ]
        
        
        // Asignamos el rootVC
        //window?.rootViewController = houseListViewController.wrappedInNavigation()
        //window?.rootViewController = tabBarViewController
        window?.rootViewController = splitViewController
        
        // Proxy para darle formato al navigation bar:
        UINavigationBar.appearance().backgroundColor = .blue

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

