//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by Sergio Cabrera Hernández on 2/3/18.
//  Copyright © 2018 Sergio Cabrera Hernández. All rights reserved.
//

import UIKit

let EPISODE_CELL_ID = "EpisodeCell"

class EpisodeListViewController: UITableViewController {
    
    // Mark: - Properties
    var episodes: [Episode]
    
    // Mark: - Initialization
    init(episodes: [Episode]) {
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
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Nos damos de alta en las notificaciones
        let notificationCenter = NotificationCenter.default
        
        // selector: Método que va a gestionar la notificación
        // name: Nombre de la notificación la cual queremos observar
        // object: Quien es el objeto que origina la notificación. Si fuera distinto de nil quizá se pueda usar un delegate
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
        // Extraer el userInfo de la notificación
        guard let info = notification.userInfo else {
            return
        }
        
        // Sacar la casa del userInfo
        let season = info[SEASON_KEY] as? Season // Cast con un opcional
        
        // Actualizar el modelo
        guard let theSeason = season else {
            return
        }
        
        self.episodes = theSeason.sortedEpisodes
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Descubrir la persona que tenemos que mostrar
        let episode = episodes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EPISODE_CELL_ID)
            ?? UITableViewCell(style: .default, reuseIdentifier: EPISODE_CELL_ID)
        
        // Sicronizar celda y persona
        cell.textLabel?.text = episode.title
        
        // Devolver la celda
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar qué episodio han pulsado
        let episode = episodes[indexPath.row]
        
        // Creamos el VC
        let episodeDetailViewController = EpisodeDetailViewController(episode: episode)
        
        // Hacemos Push
        navigationController?.pushViewController(episodeDetailViewController, animated: true)
    }
}
