//
//  MasterViewController.swift
//  Westeros
//
//  Created by Sergio Cabrera Hernández on 3/3/18.
//  Copyright © 2018 Sergio Cabrera Hernández. All rights reserved.
//

import UIKit

class MasterViewController: UITabBarController {
    // Mark: - Properties
    var houses: [House]
    var seasons: [Season]
    
    let houseListViewController: HouseListViewController
    let seasonListViewController: SeasonListViewController
    
    let houseDetailViewController: HouseDetailViewController
    let seasonDetailViewController: SeasonDetailViewController

    let houseDetailNavigationViewController: UINavigationController
    let seasonDetailNavigationViewController: UINavigationController
    
    init(houses: [House], seasons: [Season]) {
        self.houses = houses
        self.seasons = seasons
        
        houseListViewController = HouseListViewController(houses: houses)
        seasonListViewController = SeasonListViewController(seasons: seasons)
        
        houseDetailViewController = HouseDetailViewController(house: houseListViewController.lastSelectedHouse())
        seasonDetailViewController = SeasonDetailViewController(season: seasonListViewController.lastSelectedSeason())
        
        houseDetailNavigationViewController = houseDetailViewController.wrappedInNavigation()
        seasonDetailNavigationViewController = seasonDetailViewController.wrappedInNavigation()
        
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        
        self.viewControllers = [
            houseListViewController,
            seasonListViewController
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        houseListViewController.delegate = houseDetailViewController
        seasonListViewController.delegate = seasonDetailViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension MasterViewController: UITabBarControllerDelegate {
    // MARK: - Navigation
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let collapsed = splitViewController?.isCollapsed ?? true
        
        if (collapsed) {
            return
        }
        
        splitViewController?.viewControllers[1] =
            viewController == houseListViewController ? houseDetailNavigationViewController :
            seasonDetailNavigationViewController
    }
}
