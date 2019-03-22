//
//  MainScreenViewController.swift
//  SpaceTraderiOS
//
//  Created by Lauren White on 2/27/19.
//  Copyright © 2019 Lauren White. All rights reserved.
//

import Foundation
import UIKit

class MainScreenViewController: UIViewController {
    
    // UI OUTLETS
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var creditsLabel: UILabel!
    @IBOutlet var planetNameLabel: UILabel!
    @IBOutlet var planetImg: UIImageView!
    @IBOutlet var encounterImg: UIImageView!
    
    @IBOutlet var fuelProgressView: UIProgressView!
    @IBOutlet var shipTypeLabel: UILabel!
    @IBOutlet var weaponTypeLabel: UILabel!
    
    var planetImgKey: String?
    var planetName: String?
    
    let ship = player.getSpaceship()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = player.getName()
        creditsLabel.text = "$\(player.getCredits())"
        planetImg.image =  planetImgKey != nil ? UIImage(named: planetImgKey!) : nil
        planetNameLabel.text = planetName?.uppercased()
        //encounterImg.image = UIImage(named: "police")
        encounterImg.isHidden = true
        
        fuelProgressView.progress = Float(ship.getFuel() / ship.getFuelCapacity())
        shipTypeLabel.text = "Ship Type: " + ship.getType().name.uppercased()
        weaponTypeLabel.text = "Attack Blasters: " + ship.getBlasters().description.uppercased()
    }
    
    
    @IBAction func landShipSelected(_ sender: Any) {
        guard planetImg.image != nil else { return }
        guard encounterImg.isHidden else { return }
        self.performSegue(withIdentifier: "maintosurface", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MapViewController {
            destination.planetImgKey = planetImgKey
            destination.currentPlanetName = planetName
        }
        if let destination = segue.destination as? PlanetSurfaceViewController {
            destination.planetImgKey = planetImgKey
            destination.planetName = planetName
        }
        if let destination = segue.destination as? CargoScreenViewController {
            destination.planetImgKey = planetImgKey
            destination.planetName = planetName
        }
    }
    
}
