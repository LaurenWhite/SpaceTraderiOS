//
//  PlanetSurfaceViewController.swift
//  SpaceTraderiOS
//
//  Created by Lauren White on 3/9/19.
//  Copyright © 2019 Lauren White. All rights reserved.
//

import Foundation
import UIKit

class PlanetSurfaceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var planetImgKey: String?
    var planetName: String?
    
    let planets = game.getPlanets()
    
    @IBOutlet var planetNameLabel: UILabel!
    @IBOutlet var welcomeMenuView: DesignableView!
    @IBOutlet var menuMessageTextView: UITextView!
    
    @IBOutlet var tradeTableView: UITableView!
    
    let sampleGoods = ["Water", "Furs", "Ore"]
    
    
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
        planetNameLabel.text = planetName
        
        let planet = planets[extractIndexFromKey(key: planetImgKey) - 1]
        menuMessageTextView.text = "Welcome to \(planet.getName())" +
                                   "\nTech Level: \(planet.getTechLevel())" +
                                   "\nResource: \(planet.getResource())"
        
        
        tradeTableView.isHidden = true
        tradeTableView.delegate = self
        tradeTableView.dataSource = self
    }
    
    @IBAction func backButtonSelected(_ sender: Any) {
        self.performSegue(withIdentifier: "surfacetomain", sender: nil)
    }
    
    @IBAction func tradeGoodsSelected(_ sender: Any) {
        tradeTableView.isHidden = false
    }
    
    
    @IBAction func refuelShipSelected(_ sender: Any) {
    }
    
    
    private func extractIndexFromKey(key: String?) -> Int {
        guard let key = key else { return 1 }
        return Int(key.suffix(2)) ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleGoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tradegooditem", for: indexPath) as! TradeItemCell
        
        cell.decorate(name: sampleGoods[indexPath.row],
                      price: 1000,
                      quantity: 4)
        
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



class TradeItemCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func decorate(name: String, price: Int, quantity: Int){
        nameLabel.text = name
        priceLabel.text = "$\(price)"
        quantityLabel.text = String(quantity)
    }
    
}
