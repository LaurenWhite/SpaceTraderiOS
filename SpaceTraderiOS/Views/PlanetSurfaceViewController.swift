//
//  PlanetSurfaceViewController.swift
//  SpaceTraderiOS
//
//  Created by Lauren White on 3/9/19.
//  Copyright © 2019 Lauren White. All rights reserved.
//

import Foundation
import UIKit

class PlanetSurfaceViewController: UIViewController {
    
    var planetImgKey: String?
    
    let surfaceImgKeys = ["planet01" : "RedSurface1",
                          "planet02" : "BrownSurface1",
                          "planet03" : "BlueSurface1",
                          "planet04" : "BlueSurface2",
                          "planet05" : "BlueSurface3",
                          "planet06" : "BrownSurface2",
                          "planet07" : "GreenSurface1",
                          "planet08" : "PurpleSurface1",
                          "planet09" : "BlueSurface4",
                          "planet10" : "PurpleSurface2"]
    
    @IBOutlet var planetSurfaceBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planetSurfaceBackground.image = UIImage(named: surfaceImgKeys[planetImgKey ?? "planet03"] ?? "BrownSurface1")
        
    }
    
}
