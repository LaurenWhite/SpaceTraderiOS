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
    @IBOutlet var planetImg: UIImageView!
    
    var planetImgKey = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = player.getName()
        creditsLabel.text = "$\(player.getCredits())"
        planetImg.image = UIImage(named: planetImgKey)
    }
    
    
}
