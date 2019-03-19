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
    
    let planets = game.getPlanets()
    
    var planet: Planet?
    var planetImgKey: String?
    var planetName: String?
    
    var buyMenuShowing = true
    
    @IBOutlet var planetNameLabel: UILabel!
    @IBOutlet var welcomeMenuView: DesignableView!
    @IBOutlet var menuMessageTextView: UITextView!
    @IBOutlet var tradeMenuView: DesignableView!
    
    @IBOutlet var buySellButton: UIButton!
    
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
        
        planet = planets[extractIndexFromKey(key: planetImgKey) - 1]
        
        planetSurfaceBackground.image = UIImage(named: surfaceImgKeys[planetImgKey ?? "planet03"] ?? "BrownSurface1")
        planetNameLabel.text = planetName
        
        setMenuMessage()
        
        tradeMenuView.isHidden = true
        buyMenuShowing = true
        buySellButton.titleLabel?.text = "Buy"
        
        tradeTableView.delegate = self
        tradeTableView.dataSource = self
    }
    
    @IBAction func backButtonSelected(_ sender: Any) {
        self.performSegue(withIdentifier: "surfacetomain", sender: nil)
    }
    
    @IBAction func tradeGoodsSelected(_ sender: Any) {
        tradeMenuView.isHidden = false
    }
    
    
    @IBAction func refuelShipSelected(_ sender: Any) {
    }
    
    @IBAction func planetGoodsSelected(_ sender: Any) {
        buyMenuShowing = true
        buySellButton.titleLabel?.text = "Buy"
    }
    
    @IBAction func myGoodsSelected(_ sender: Any) {
        buyMenuShowing = false
        buySellButton.titleLabel?.text = "Sell"
    }
    
    private func setMenuMessage() {
        guard let planet = planet else { return }
        
        let techLevelString = enumToString(tl: planet.getTechLevel())
        let resourceString = enumToString(resource: planet.getResource())
        
        menuMessageTextView.text = "Welcome to \(planet.getName())!" +
                                    "\nTech Level: \(techLevelString)" +
                                    "\nResource: \(resourceString)"
    }
    
    private func extractIndexFromKey(key: String?) -> Int {
        guard let key = key else { return 1 }
        return Int(key.suffix(2)) ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let planet = planet else { return 3 }
        
        if buyMenuShowing {
            return planet.getMarket().count
        } else {
            return player.getSpaceship().getCargo().count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tradegooditem", for: indexPath) as! TradeItemCell
        
        guard let planet = planet else { return cell }
        let market = planet.getMarket()
        let selectedItem = market[indexPath.row]
        
        cell.decorate(name: selectedItem.good.name,
                      price: selectedItem.price,
                      quantity: selectedItem.quantity)
        
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
