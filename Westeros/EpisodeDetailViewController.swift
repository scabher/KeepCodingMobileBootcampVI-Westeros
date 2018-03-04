//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Sergio Cabrera Hernández on 3/3/18.
//  Copyright © 2018 Sergio Cabrera Hernández. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    // Mark: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateOfIssueLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var PlotTextView: UITextView!
    
    // Mark: - Properties
    var episode: Episode
    
    // Mark: - Initialization
    init(episode: Episode) {
        self.episode = episode
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = episode.title
        
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
        notificationCenter.addObserver(self, selector: #selector(seasonDidChange),
                                       name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Nos damos de baja de las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    // MARK: - Notifications
    @objc func seasonDidChange(notification: Notification) {
        navigationController?.popToRootViewController(animated: true)
    }

    // Mark: - Sync
    func syncModelWithView() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        // Model -> View
        title = episode.title
        titleLabel.text = episode.title
        dateOfIssueLabel.text = dateFormatter.string(from: episode.dateOfIssue)
        seasonLabel.text = episode.season.name
        PlotTextView.text = episode.plot
    }
}

