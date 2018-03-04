//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Sergio Cabrera Hernández on 19/2/18.
//  Copyright © 2018 Sergio Cabrera Hernández. All rights reserved.
//

import UIKit

let MEMBER_CELL_ID = "MemberCell"

class MemberListViewController: UITableViewController {
    
    // Mark: - Properties
    var members: [Person]
    
    // Mark: - Initialization
    init(members: [Person]) {
        self.members = members
        super.init(nibName: nil, bundle: nil)
        title = "Members"
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
        // Extraer el userInfo de la notificación
        guard let info = notification.userInfo else {
            return
        }
        
        // Sacar la casa del userInfo
        let house = info[HOUSE_KEY] as? House // Cast con un opcional
        
        // Actualizar el modelo
        guard let theHouse = house else {
            return
        }
        
        self.members = theHouse.sortedMembers
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Descubrir la persona que tenemos que mostrar
        let person = members[indexPath.row]
        
        // Preguntar por una celda (a una cache) o Crearla
        //        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        //        if cell == nil {
        //            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        //        }
        let cell = tableView.dequeueReusableCell(withIdentifier: MEMBER_CELL_ID)
            ?? UITableViewCell(style: .default, reuseIdentifier: MEMBER_CELL_ID)
        
        // Sicronizar celda y persona
        cell.textLabel?.text = person.fullName
        
        // Devolver la celda
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar qué miembro han pulsado
        let member = members[indexPath.row]
        
        // Creamos el VC
        let memberDetailViewController = MemberDetailViewController(member: member)
        
        // Hacemos Push
        navigationController?.pushViewController(memberDetailViewController, animated: true)
    }
}


