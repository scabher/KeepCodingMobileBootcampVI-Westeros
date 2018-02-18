//
//  UIViewController+Additions.swift
//  Westeros
//
//  Created by Sergio Cabrera on 13/02/2018.
//  Copyright © 2018 Sergio Cabrera. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func wrappedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
