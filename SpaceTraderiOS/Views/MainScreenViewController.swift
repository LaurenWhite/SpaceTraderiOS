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
    
    var planetImgKey: String?
    var planetName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = player.getName()
        creditsLabel.text = "$\(player.getCredits())"
        planetImg.image =  planetImgKey != nil ? UIImage(named: planetImgKey!) : nil
        planetNameLabel.text = planetName?.uppercased()
        //encounterImg.image = UIImage(named: "police")
        encounterImg.isHidden = true
    }
    

    @IBAction func planetImgSelected(_ sender: Any) {
        print("planet clicked!")
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
        }
    }
    
}
