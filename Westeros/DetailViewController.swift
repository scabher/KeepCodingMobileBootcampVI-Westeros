//
//  DetailViewController.swift
//  Westeros
//
//  Created by Sergio Cabrera Hernández on 3/3/18.
//  Copyright © 2018 Sergio Cabrera Hernández. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let houseDetailViewController: HouseDetailViewController
    let seasonDetailViewController: SeasonDetailViewController
    
    let houseDetailNavigationViewController: UINavigationController
    let seasonDetailNavigationViewController: UINavigationController
    
    let season: Season
    let house: House
    
    init(season : Season, house: House) {
        self.season = season
        self.house = house
        houseDetailViewController = HouseDetailViewController(house: house)
        seasonDetailViewController = SeasonDetailViewController(season: season)
        
        houseDetailNavigationViewController = houseDetailViewController.wrappedInNavigation()
        seasonDetailNavigationViewController = seasonDetailViewController.wrappedInNavigation()
        
        super.init(nibName: nil, bundle: nil)
        
        // Hacemos push
        navigationController?.pushViewController(houseDetailViewController, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//extension DetailViewController: UITabBarControllerDelegate {
//    // MARK: - Navigation
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        let collapsed = splitViewController?.isCollapsed ?? true
//
//        if (collapsed) {
//            return
//        }
//
//        splitViewController?.viewControllers[1] =
//            viewController == houseListViewController ? houseDetailNavigationViewController :
//        seasonDetailNavigationViewController
//    }
//}

