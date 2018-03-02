//
//  SeasonListTableViewController.swift
//  Westeros
//
//  Created by Sergio Cabrera Hernández on 28/2/18.
//  Copyright © 2018 Sergio Cabrera Hernández. All rights reserved.
//

import UIKit

let SEASON_KEY = "SeasonKey"
let SEASON_DID_CHANGE_NOTIFICATION_NAME = "SeasonDidChange"
let LAST_SEASON = "LastSeason"
let SEASON_CELL_ID = "SeasonCell"

// Delegado para comunicar este VC con el VC del detalle de la temporada
protocol SeasonListViewControllerDelegate: class {
    // should, will, did
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason: Season)
}

class SeasonListViewController: UITableViewController {
    
    // MARK: - Properties
    let seasons: [Season]
    weak var delegate: SeasonListViewControllerDelegate?
    
    // MARK: - Initialization
    init(seasons: [Season]) {
        self.seasons = seasons
        super.init(style: .plain)
        title = "Seasons"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Selección de la última fila seleccionada
        let lastRow = UserDefaults.standard.integer(forKey: LAST_SEASON)
        let indexPath = IndexPath(row: lastRow, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Descubrir cual es la casa que tenemos que mostrar
        let season = seasons[indexPath.row]
        
        // Crear una celda
        var cell = tableView.dequeueReusableCell(withIdentifier: SEASON_CELL_ID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: SEASON_CELL_ID)
        }
        
        // Sincroniza season (modelo) con cell (vista)
        cell?.textLabel?.text = season.name
        
        return cell!
    }


    // MARK: Table View Delegate
    // Por convención se usa should, will, did para saber cuándo se va a ejecutar el método
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar qué casa han pulsado
        let season = seasons[indexPath.row]
        
        // Usando splitViewController
        // Se notifica la nueva temporada seleccionada en la lista de temporadas
        delegate?.seasonListViewController(self, didSelectSeason: season)
        
        // Mando la misma info a través de notificaciones (para el resto de controladores)
        let notificationCenter = NotificationCenter.default
        let notificacion = Notification(name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [SEASON_KEY : season])
        
        notificationCenter.post(notificacion)
        
        // Guardar las coordenadas (section, row) de la última casa seleccionada
        saveLastSelectedSeason(at: indexPath.row)
    }
}

extension SeasonListViewController {
    func saveLastSelectedSeason(at row: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: LAST_SEASON)
        
        // Por si a caso, nos aseguramos de que efectivamente se guarda
        defaults.synchronize()
    }
    
    func lastSelectedSeason() -> Season {
        // Extraer la row del User Defaults
        let row = UserDefaults.standard.integer(forKey: LAST_SEASON)
        
        // Averigüar la casa de ese row
        let season = seasons[row]
        
        // Devolver la casa
        return season
    }
}
