//
//  HouseListViewController.swift
//  Westeros
//
//  Created by Sergio Cabrera on 15/02/2018.
//  Copyright © 2018 Sergio Cabrera. All rights reserved.
//

import UIKit

class HouseListViewController: UITableViewController {
    
    // Mark: - Properties
    let model: [House]
    
    // Mark: - Initialization
    init(model: [House]) {
        self.model = model
        super.init(style: .plain)
        title = "Westeros"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Habrá un identificador por tipo de celda (según su formato - con switch, con imagen, con título y subtítulo, etc... -
        // para que luego se busque en la caché una celda del mismo tipo a la que se quiere ubicar en memoria
        let cellId = "HouseCell"
        
        // Descubrir cual es la casa que tenemos que mostrar
        let house = model[indexPath.row]
        
        // Crear una celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincroniza house (model) con cell (vista)
        cell?.imageView?.image = house.sigil.image
        cell?.textLabel?.text = house.name
        
        return cell!
        
    }
    
    // MARK: Table View Delegate
    // Por convención se usa should, will, did para saber cuándo se va a ejecutar el método
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar qué casa han pulsado
        let house = model[indexPath.row]
        
        // Crear un controlador de detalle de esa casa
        let houseDetailViewController = HouseDetailViewController(model: house)
        
        // Hacer un push
        navigationController?.pushViewController(houseDetailViewController, animated: true)
    }
    
}
