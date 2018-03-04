//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Sergio Cabrera Hernández on 1/3/18.
//  Copyright © 2018 Sergio Cabrera Hernández. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {

    // Mark: - Outlets
    @IBOutlet weak var seasonNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    // Mark: - Properties
    var season: Season
    
    // Mark: - Initialization
    init(season: Season) {
        // Primero, limpias tu propio desorder
        self.season = season
        // Llamas a super
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = season.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        syncModelWithView()
    }
    
    // Mark: - Sync
    func syncModelWithView() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        // Model -> View
        title = season.name
        seasonNameLabel.text = season.name
        releaseDateLabel.text = dateFormatter.string(from: season.releaseDate)
    }
    
    // MARK: - UI
    func setupUI() {
        let episodes = UIBarButtonItem(title: "Episodes", style: .plain, target: self, action: #selector(displayEpisodes))
        
        navigationItem.rightBarButtonItems = [episodes]
    }

    @objc func displayEpisodes() {
        // Creamos el VC
        let episodeListViewController = EpisodeListViewController(episodes: season.sortedEpisodes)
        
        // Hacemos Push
        navigationController?.pushViewController(episodeListViewController, animated: true)
    }
}

extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season) {
        self.season = season
        syncModelWithView()
    }
}
