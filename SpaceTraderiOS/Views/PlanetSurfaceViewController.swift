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
    
    
    //      VARIABLES       //
    
    let planets = game.getPlanets()
    
    // Planet information
    var planet: Planet?
    var planetImgKey: String?
    var planetName: String?
    
    // Info flag for trade menu type
    var buyMenuShowing = true
    
    // If selected, current selected item in table view
    var selectedItem: MarketItem? = nil
    
    // Surface image based on selected planet color
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
    
    
    
    //      UI OUTLETS      //
    
    // Surface background image display view
    @IBOutlet var planetSurfaceBackground: UIImageView!
    
    // Title labels
    @IBOutlet var planetNameLabel: UILabel!
    
    // Menus and Pop ups
    @IBOutlet var welcomeMenuView: DesignableView!
    @IBOutlet var menuMessageTextView: UITextView!
    
    // Trade menu outlets
    @IBOutlet var tradeMenuView: DesignableView!
    @IBOutlet var buySellButton: UIButton!
    @IBOutlet var tradeTableView: UITableView!
    
    @IBOutlet var goodNameLabel: UILabel!
    @IBOutlet var goodPriceLabel: UILabel!
    @IBOutlet var goodWeightLabel: UILabel!
    
    @IBOutlet var quantityLabel: UILabel!
    @IBOutlet var quantityStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planet = planets[extractIndexFromKey(key: planetImgKey) - 1]
        
        planetSurfaceBackground.image = UIImage(named: surfaceImgKeys[planetImgKey ?? "planet03"] ?? "BrownSurface1")
        planetNameLabel.text = planetName
        
        updateCargoPrices()
        setMenuMessage()
        
        tradeMenuView.isHidden = true
        buyMenuShowing = true
        buySellButton.setTitle("Buy", for: .normal)
        
        tradeTableView.delegate = self
        tradeTableView.dataSource = self
        
        goodNameLabel.text = "None"
        goodPriceLabel.text = "$0"
        goodWeightLabel.text = "0 lbs"
        
        quantityStepper.minimumValue = 0
        quantityStepper.maximumValue = 15
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
        buySellButton.setTitle("Buy", for: .normal)
        goodNameLabel.text = "None"
        selectedItem = nil
        quantityStepper.value = 0
        quantityChanged(self)
        tradeTableView.reloadData()
    }
    
    @IBAction func myGoodsSelected(_ sender: Any) {
        buyMenuShowing = false
        buySellButton.setTitle("Sell", for: .normal)
        goodNameLabel.text = "None"
        selectedItem = nil
        quantityStepper.value = 0
        quantityChanged(self)
        tradeTableView.reloadData()
    }
    
    private func setMenuMessage() {
        guard let planet = planet else { return }
        
        let techLevelString = enumToString(tl: planet.getTechLevel())
        let resourceString = enumToString(resource: planet.getResource())
        
        menuMessageTextView.text = "Welcome to \(planet.getName())!" +
                                    "\nTech Level: \(techLevelString)" +
                                    "\nResource: \(resourceString)"
    }
    
    private func updateCargoPrices() {
        guard let planet = planet else { return }
        player.getSpaceship().updateRegionalPrices(planet: planet)
    }
    
    private func extractIndexFromKey(key: String?) -> Int {
        guard let key = key else { return 1 }
        return Int(key.suffix(2)) ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let planet = planet else { return 9 }
        
        if buyMenuShowing {
            return planet.getMarket().count
        } else {
            return player.getSpaceship().getCargo().count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tradegooditem", for: indexPath) as! TradeItemCell
        
        guard let  planet = planet else { return cell }
        
        if buyMenuShowing {
            let market = planet.getMarket()
            let selectedItem = market[indexPath.row]
            cell.decorate(name: selectedItem.good.name,
                          price: selectedItem.price,
                          quantity: selectedItem.quantity)
            cell.normalStyle()
        } else {
            let cargo = player.getSpaceship().getCargo()
            let selectedItem = cargo[indexPath.row]
            cell.decorate(name: selectedItem.good.name,
                          price: selectedItem.price,
                          quantity: selectedItem.quantity)
            cell.normalStyle()
            if !planet.canUseItem(item: selectedItem) {
                cell.disabledStyle()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        quantityStepper.value = 0
        quantityChanged(self)
        
        var currentItem: MarketItem
        if buyMenuShowing {
            guard let planet = planet else { return }
            let market = planet.getMarket()
            currentItem = market[indexPath.row]
        } else {
            let cargo = player.getSpaceship().getCargo()
            currentItem = cargo[indexPath.row]
        }
        
        goodNameLabel.text = currentItem.good.name
        selectedItem = currentItem
        quantityStepper.maximumValue = Double(currentItem.quantity)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let  planet = planet else { return indexPath }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tradegooditem", for: indexPath) as! TradeItemCell
        
        if !buyMenuShowing {
            let cargo = player.getSpaceship().getCargo()
            let currentItem = cargo[indexPath.row]
            if(!planet.canUseItem(item: currentItem)) {
                cell.selectionStyle = .none
                cell.isUserInteractionEnabled = false
                return nil
            }
        }
        
        return indexPath
    }
    
    @IBAction func quantityChanged(_ sender: Any) {
        guard let selectedItem = selectedItem else { return }
        
        let newQuantity = Int(quantityStepper.value)
        quantityLabel.text = "Quantity:  \(newQuantity)"
        
        let newPrice = selectedItem.price * newQuantity
        let newWeight = selectedItem.good.weight * newQuantity
        goodPriceLabel.text = "$\(newPrice)"
        goodWeightLabel.text = "\(newWeight) lbs"
    }
    
    
    @IBAction func buySellButtonSelected(_ sender: Any) {
        guard let selectedItem = selectedItem else { return }
        guard let planet = planet else { return }
        let ship = player.getSpaceship()
        
        let totalPrice = selectedItem.price * Int(quantityStepper.value)
        let totalWeight = selectedItem.good.weight * Int(quantityStepper.value)
        let transactionItem = MarketItem(good: selectedItem.good,
                                         quantity: Int(quantityStepper.value),
                                         price: selectedItem.price)
        print("Player Credits (before): \(player.getCredits())")
        
        if buyMenuShowing {
            guard player.hasSufficientFunds(cost: totalPrice) else { return }
            guard ship.hasSufficientSpace(newWeight: totalWeight) else { return }
            player.setCredits(newCredits: player.getCredits() - totalPrice)
            ship.addToCargo(newItem: transactionItem)
            planet.sellToPlayer(item: transactionItem)
        } else {
            guard planet.canUseItem(item: transactionItem) else { return }
            player.setCredits(newCredits: player.getCredits() + totalPrice)
            ship.removeFromCargo(item: transactionItem)
            planet.buyFromPlayer(item: transactionItem)
        }
        print("Player Credits (after): \(player.getCredits())")
        print()
        quantityStepper.value = 0
        quantityChanged(self)
        tradeTableView.reloadData()
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
    
    func decorate(name: String, price: Int, quantity: Int) {
        nameLabel.text = name
        priceLabel.text = "$\(price)"
        quantityLabel.text = String(quantity)
    }
    
    func normalStyle() {
        nameLabel.textColor = UIColor(red: 118/255, green: 214/255, blue: 255/255, alpha: 1)
        priceLabel.textColor = UIColor(red: 118/255, green: 214/255, blue: 255/255, alpha: 1)
        quantityLabel.textColor = UIColor(red: 118/255, green: 214/255, blue: 255/255, alpha: 1)
    }
    
    func disabledStyle() {
        nameLabel.textColor = UIColor.darkGray
        priceLabel.textColor = UIColor.darkGray
        quantityLabel.textColor = UIColor.darkGray
    }
    
}
