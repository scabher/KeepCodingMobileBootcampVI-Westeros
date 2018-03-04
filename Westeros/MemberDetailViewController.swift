//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by Sergio Cabrera Hernández on 4/3/18.
//  Copyright © 2018 Sergio Cabrera Hernández. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {
    
    // Mark: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    
    // Mark: - Properties
    var member: Person
    
    // Mark: - Initialization
    init(member: Person) {
        self.member = member
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = member.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
        
        // Nos damos de alta en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(houseDidChange),
                                       name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Nos damos de baja de las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    // MARK: - Notifications
    @objc func houseDidChange(notification: Notification) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // Mark: - Sync
    func syncModelWithView() {
       
        // Model -> View
        title = member.name
        nameLabel.text = member.name
        aliasLabel.text = member.alias
        houseLabel.text = member.house.name
    }
}
