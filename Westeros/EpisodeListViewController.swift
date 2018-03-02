//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by Sergio Cabrera Hernández on 2/3/18.
//  Copyright © 2018 Sergio Cabrera Hernández. All rights reserved.
//

import UIKit

let EPISODE_CELL_ID = "EpisodeCell"

class EpisodeListViewController: UIViewController {
    // Mark: - Outlets
    @IBOutlet var episodeTableView: UITableView!
    
    // Mark: - Properties
    let episodes: Episodes
    
    // Mark: - Initialization
    init(episodes: Episodes) {
        self.episodes = episodes
        super.init(nibName: nil, bundle: nil)
        title = "Episodes"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Asignamos la fuente de datos
        episodeTableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource
extension EpisodeListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        // Descubrir la persona que tenemos que mostrar
        let episode = Array(episodes)[indexPath.row]
      
        let cell = tableView.dequeueReusableCell(withIdentifier: EPISODE_CELL_ID)
            ?? UITableViewCell(style: .default, reuseIdentifier: EPISODE_CELL_ID)
        
        // Sicronizar celda y persona
        cell.textLabel?.text = episode.title
        
        // Devolver la celda
        return cell
    }
}
