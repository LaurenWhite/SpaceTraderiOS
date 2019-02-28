//
//  MapViewController.swift
//  SpaceTraderiOS
//
//  Created by Lauren White on 2/27/19.
//  Copyright © 2019 Lauren White. All rights reserved.
//

import Foundation
import UIKit

class MapViewController: UIViewController {
    
    var planets = game.getPlanets()
    var planetImgKey: String = ""
    
    @IBOutlet var planet1Img: UIImageView!
    @IBOutlet var planet2Img: UIImageView!
    @IBOutlet var planet3Img: UIImageView!
    @IBOutlet var planet4Img: UIImageView!
    @IBOutlet var planet5Img: UIImageView!
    @IBOutlet var planet6Img: UIImageView!
    @IBOutlet var planet7Img: UIImageView!
    @IBOutlet var planet8Img: UIImageView!
    @IBOutlet var planet9Img: UIImageView!
    @IBOutlet var planet10Img: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImages()
        displayAtLocation()
    }
    
    private func setImages() {
        planet1Img.image = UIImage(named: "planet01")
        planet2Img.image = UIImage(named: "planet02")
        planet3Img.image = UIImage(named: "planet03")
        planet4Img.image = UIImage(named: "planet04")
        planet5Img.image = UIImage(named: "planet05")
        planet6Img.image = UIImage(named: "planet06")
        planet7Img.image = UIImage(named: "planet07")
        planet8Img.image = UIImage(named: "planet08")
        planet9Img.image = UIImage(named: "planet09")
        planet10Img.image = UIImage(named: "planet10")
    }
    
    private func displayAtLocation() {
        planet1Img.frame = CGRect(x: planets[0].getLocation().0, y: planets[0].getLocation().1, width: 50, height: 50)
        planet2Img.frame = CGRect(x: planets[1].getLocation().0, y: planets[1].getLocation().1, width: 50, height: 50)
        planet3Img.frame = CGRect(x: planets[2].getLocation().0, y: planets[2].getLocation().1, width: 50, height: 50)
        planet4Img.frame = CGRect(x: planets[3].getLocation().0, y: planets[3].getLocation().1, width: 50, height: 50)
        planet5Img.frame = CGRect(x: planets[4].getLocation().0, y: planets[4].getLocation().1, width: 50, height: 50)
        planet6Img.frame = CGRect(x: planets[5].getLocation().0, y: planets[5].getLocation().1, width: 50, height: 50)
        planet7Img.frame = CGRect(x: planets[6].getLocation().0, y: planets[6].getLocation().1, width: 50, height: 50)
        planet8Img.frame = CGRect(x: planets[7].getLocation().0, y: planets[7].getLocation().1, width: 50, height: 50)
        planet9Img.frame = CGRect(x: planets[8].getLocation().0, y: planets[8].getLocation().1, width: 50, height: 50)
        planet10Img.frame = CGRect(x: planets[9].getLocation().0, y: planets[9].getLocation().1, width: 50, height: 50)
    }
    
    @IBAction func p1Selected(_ sender: Any) {
        planetImgKey = "planet01"
        self.performSegue(withIdentifier: "maptomain", sender: nil)
    }
    
    @IBAction func p2Selected(_ sender: Any) {
        planetImgKey = "planet02"
        self.performSegue(withIdentifier: "maptomain", sender: nil)
    }
    
    @IBAction func p3Selected(_ sender: Any) {
        planetImgKey = "planet03"
        self.performSegue(withIdentifier: "maptomain", sender: nil)
    }
    
    @IBAction func p4Selected(_ sender: Any) {
        planetImgKey = "planet04"
        self.performSegue(withIdentifier: "maptomain", sender: nil)
    }
    
    @IBAction func p5Selected(_ sender: Any) {
        planetImgKey = "planet05"
        self.performSegue(withIdentifier: "maptomain", sender: nil)
    }
    
    @IBAction func p6Selected(_ sender: Any) {
        planetImgKey = "planet06"
        self.performSegue(withIdentifier: "maptomain", sender: nil)
    }
    
    @IBAction func p7Selected(_ sender: Any) {
        planetImgKey = "planet07"
        self.performSegue(withIdentifier: "maptomain", sender: nil)
    }
    @IBAction func p8Selected(_ sender: Any) {
        planetImgKey = "planet08"
        self.performSegue(withIdentifier: "maptomain", sender: nil)
    }
    @IBAction func p9Selected(_ sender: Any) {
        planetImgKey = "planet09"
        self.performSegue(withIdentifier: "maptomain", sender: nil)
    }
    
    @IBAction func p10Selected(_ sender: Any) {
        planetImgKey = "planet10"
        self.performSegue(withIdentifier: "maptomain", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MainScreenViewController {
            destination.planetImgKey = planetImgKey
        }
    }
}
