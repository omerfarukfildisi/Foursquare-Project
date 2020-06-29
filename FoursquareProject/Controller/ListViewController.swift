//
//  ListView.swift
//  FoursquareProject
//
//  Created by Ömer Faruk Fildişi on 26.06.2019.
//  Copyright © 2019 Ömer Faruk Fildişi. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet weak var mainTableView: UITableView!
    var vens: [VenueResponseModel] = [VenueResponseModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        mainTableView.register(UINib(nibName: "VanueTableViewCell", bundle: .none), forCellReuseIdentifier: "VenueCell")
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if vens.count > 0 {
            return vens.count
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenueCell", for: indexPath) as! VanueTableViewCell
        
        cell.setCell(name: vens[indexPath.row].name!, adress: "\((vens[indexPath.row].location?.address ?? "adress yok")!) \((vens[indexPath.row].location?.city ?? "city yok")!)\n\((vens[indexPath.row].location?.state ?? "state yok")!)")
       return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "popupChanged", sender: vens[indexPath.row])
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popupChanged" {
            let destination = segue.destination as! PopupViewController
            destination.ven = sender as? VenueResponseModel
            
        }
    }
    
    
    
    
}
