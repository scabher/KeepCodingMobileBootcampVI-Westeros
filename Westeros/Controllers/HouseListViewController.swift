//
//  HouseListViewController.swift
//  Westeros
//
//  Created by Sergio Cabrera on 15/02/2018.
//  Copyright © 2018 Sergio Cabrera. All rights reserved.
//

import UIKit

let HOUSE_KEY = "HouseKey"
let HOUSE_DID_CHANGE_NOTIFICATION_NAME = "HouseDidChange"
let LAST_HOUSE = "LastHouse"
let HOUSE_CELL_ID = "HouseCell"
let HOUSE_TITLE = "Houses"

// Delegado para comunicar este VC con el VC del detalle de la casa
protocol HouseListViewControllerDelegate: class {
    // should, will, did
    func houseListViewController(_ vc: HouseListViewController, didSelectHouse: House)
}

class HouseListViewController: UITableViewController {
    
    // MARK: - Properties
    let houses: [House]
    weak var delegate: HouseListViewControllerDelegate?
    
    // MARK: - Initialization
    init(houses: [House]) {
        self.houses = houses
        super.init(style: .plain)
        title = HOUSE_TITLE
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let lastRow = UserDefaults.standard.integer(forKey: LAST_HOUSE)
        let indexPath = IndexPath(row: lastRow, section: 0)
        
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Habrá un identificador por tipo de celda (según su formato - con switch, con imagen, con título y subtítulo, etc... -
        // HOUSE_CELL_ID: para que luego se busque en la caché una celda del mismo tipo a la que se quiere ubicar en memoria
        
        // Descubrir cual es la casa que tenemos que mostrar
        let house = houses[indexPath.row]
        
        // Crear una celda
        var cell = tableView.dequeueReusableCell(withIdentifier: HOUSE_CELL_ID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: HOUSE_CELL_ID)
        }
        
        // Sincroniza house (model) con cell (vista)
        cell?.imageView?.image = house.sigil.image
        cell?.textLabel?.text = house.name
        
        return cell!
    }
    
    // MARK: - Table View Delegate
    // Por convención se usa should, will, did para saber cuándo se va a ejecutar el método
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar qué casa han pulsado
        let house = houses[indexPath.row]
        
        // Usando splitViewController
        // Se notifica la nueva casa seleccionada en la lista de casas
        delegate?.houseListViewController(self, didSelectHouse: house)
        
        // Mando la misma info a través de notificaciones (para el resto de controladores)
        let notificationCenter = NotificationCenter.default
        let notificacion = Notification(
            name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME),
            object: self,
            userInfo: [HOUSE_KEY : house]
        )
        
        notificationCenter.post(notificacion)
        
        // Guardar las coordenadas (section, row) de la última casa seleccionada
        saveLastSelectedHouse(at: indexPath.row)
    }
}

extension HouseListViewController {
    func saveLastSelectedHouse(at row: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: LAST_HOUSE)
        
        // Por si a caso, nos aseguramos de que efectivamente se guarda
        defaults.synchronize()
    }
    
    func lastSelectedHouse() -> House {
        // Extraer la row del User Defaults
        let row = UserDefaults.standard.integer(forKey: LAST_HOUSE)
        
        // Averigüar la casa de ese row
        let house = houses[row]
        
        // Devolver la casa
        return house
    }
}
