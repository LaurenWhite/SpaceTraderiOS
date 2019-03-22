//
//  CargoScreenViewController.swift
//  SpaceTraderiOS
//
//  Created by Lauren White on 3/19/19.
//  Copyright © 2019 Lauren White. All rights reserved.
//

import Foundation
import UIKit

class CargoScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var planetImgKey: String?
    var planetName: String?
    
    let cargo = player.getSpaceship().getCargo()
    
    @IBOutlet var cargoTableView: UITableView!
    
    override func viewDidLoad() {
        cargoTableView.delegate = self
        cargoTableView.dataSource = self
    }
    
    @IBAction func backButtonSelected(_ sender: Any) {
        self.performSegue(withIdentifier: "cargotomain", sender: nil)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cargo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tradegooditem", for: indexPath) as! TradeItemCell
        
        let item = cargo[indexPath.row]

        cell.decorate(name: item.good.name,
                      price: item.price,
                      quantity: item.quantity)
        cell.normalStyle()

        return cell
    }
    
    //      SEGUE PREPERATION      //
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MainScreenViewController {
            destination.planetImgKey = planetImgKey
            destination.planetName = planetName
        }
    }
}
