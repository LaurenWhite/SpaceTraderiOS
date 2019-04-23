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
    
    //      UI OUTLETS       //
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var creditsLabel: UILabel!
    @IBOutlet var planetNameLabel: UILabel!
    @IBOutlet var planetImg: UIImageView!
    @IBOutlet var encounterImg: UIImageView!
    
    @IBOutlet var fuelProgressView: UIProgressView!
    @IBOutlet var shipTypeLabel: UILabel!
    @IBOutlet var weaponTypeLabel: UILabel!
    
    // Encounter Pop Up Menu
    @IBOutlet var encounterPopUpView: DesignableView!
    @IBOutlet var encounterMessage: UITextView!
    @IBOutlet var peaceOptionButton: UIButton!
    @IBOutlet var combatOptionButton: UIButton!
    
    
    //      VARIABLES       //
    
    // Planet information to be passed to other views
    var planetImgKey: String?
    var planetName: String?
    var eventChances: [String : Int]?
    var eventKey: String?
    
    // Current ship for player
    let ship = player.getSpaceship()
    
    // Trade variables
    var yourItem: MarketItem?
    var theirItem: MarketItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = player.getName()
        creditsLabel.text = "$\(player.getCredits())"
        planetImg.image =  planetImgKey != nil ? UIImage(named: planetImgKey!) : nil
        planetNameLabel.text = planetName?.uppercased()
        
        fuelProgressView.progress = Float(ship.getFuel() / ship.getFuelCapacity())
        shipTypeLabel.text = "Ship Type: " + ship.getType().name.uppercased()
        weaponTypeLabel.text = "Attack Blasters: " + ship.getBlasters().description.uppercased()
        
        // Defualt hide event images
        encounterImg.isHidden = true
        encounterPopUpView.isHidden = true
        
        // Check for if by random chancing, an event is to occur
        if checkForEvent() {
            guard let eventKey = eventKey else { return }
            encounterImg.image = UIImage(named: eventKey)
            encounterImg.isHidden = false
        }
    }
    
    
    // If ship has traveled to a planet, go to the surface
    @IBAction func landShipSelected(_ sender: Any) {
        guard planetImg.image != nil else { return }
        if !encounterImg.isHidden {
            setUpEncounterMenu()
            encounterPopUpView.isHidden = false
            return
        }
        self.performSegue(withIdentifier: "maintosurface", sender: nil)
    }
    
    // TODO: Peristence not yet fully implemented
    @IBAction func saveButtonSelected(_ sender: Any) {
        //database.saveGame()
    }
    
    
    // Check chance of an event happening and set key to most likely event
    private func checkForEvent() -> Bool {
        guard let eventChances = eventChances else { return false }
        let rand = Int.random(in: 1...10)
        print(rand)
        guard rand > 3 else { return false }
        
        var max = eventChances["trader"] as! Int
        eventKey = "trader"
        
        if(eventChances["police"] as! Int > max) {
            max =  eventChances["police"] as! Int
            eventKey = "police"
        }
        if(eventChances["mercenary"] as! Int > max) {
            max =  eventChances["mercenary"] as! Int
            eventKey = "mercenary"
        }
        
        print(eventKey)
        return true
    }
    
    // Customize encounter options based on the type of ship the player is encountering
    private func setUpEncounterMenu() {
        guard let eventKey = eventKey else { return }
        encounterMessage.text = "You have encountered a \(eventKey)! What would you like to do about it?"
        if(eventKey == "trader") {
            peaceOptionButton.setTitle("Trade Goods", for: .normal)
            combatOptionButton.setTitle("Steal Goods", for: .normal)
        } else if (eventKey == "police" || eventKey == "mercenary") {
            peaceOptionButton.setTitle("Talk", for: .normal)
            combatOptionButton.setTitle("Fight", for: .normal)
        }
    }
    
    // Various event menu options for if peaceful action is selected
    @IBAction func peaceButtonSelected(_ sender: Any) {
        guard !encounterPopUpView.isHidden else { return }
        guard let eventKey = eventKey else { return }
        
        guard !combatOptionButton.isHidden else {
            closeEventMenu()
            return
        }
        
        if(eventKey == "trader") {
            if(peaceOptionButton.titleLabel?.text == "Agree") {
                guard let yourItem = yourItem else { return }
                guard let theirItem = theirItem else { return }
                ship.removeFromCargo(item: yourItem)
                ship.addToCargo(newItem: theirItem)
                closeEventMenu()
                return
            }
            
            if(ship.getCargo().isEmpty) {
                encounterMessage.text = "You have nothing to trade"
                peaceOptionButton.setTitle("Ok", for: .normal)
                combatOptionButton.isHidden = true
            } else {
                let randInx = Int.random(in: 0...ship.getCargo().count - 1)
                yourItem = ship.getCargo()[randInx]
                theirItem = randomTradeItem()
                encounterMessage.text = "The trader would like \(yourItem!.quantity) of your \(yourItem!.good.name) for \(theirItem!.quantity) of their \(theirItem!.good.name)"
                peaceOptionButton.setTitle("Agree", for: .normal)
                combatOptionButton.setTitle("Refuse", for: .normal)
            }
        } else if (eventKey == "police") {
            if(ship.getHasStolenGoods()) {
                encounterMessage.text = "The police have fined you $100 for having stolen goods!"
                player.setCredits(newCredits: player.getCredits() - 100)
                peaceOptionButton.setTitle("Ok", for: .normal)
                combatOptionButton.isHidden = true
            } else {
                encounterMessage.text = "The police have wished you safe travels!"
                peaceOptionButton.setTitle("Ok", for: .normal)
                combatOptionButton.isHidden = true
            }
        } else if (eventKey == "mercenary") {
            encounterMessage.text = "The mercenary stole all of your goods!"
            ship.clearCargo()
            peaceOptionButton.setTitle("Ok", for: .normal)
            combatOptionButton.isHidden = true
        }
    }
    
    
    // Various event menu options for if combat action is selected
    @IBAction func combatButtonSelected(_ sender: Any) {
        guard !encounterPopUpView.isHidden else { return }
        guard let eventKey = eventKey else { return }
        
        guard !combatOptionButton.isHidden else {
            encounterPopUpView.isHidden = true
            encounterImg.isHidden = true
            return
        }
        
        if(eventKey == "trader") {
            if(combatOptionButton.titleLabel?.text == "Refuse") {
                closeEventMenu()
                return
            }
            
            encounterMessage.text = "You stole the trader's goods!"
            ship.setHasStolenGoods(stolen: true)
            peaceOptionButton.setTitle("Ok", for: .normal)
            combatOptionButton.isHidden = true
        } else if (eventKey == "police") {
            if(ship.getBlasters()) {
                encounterMessage.text = "You defeated the police!"
                peaceOptionButton.setTitle("Ok", for: .normal)
                combatOptionButton.isHidden = true
            } else {
                encounterMessage.text = "The police have defeated you and fined you $400"
                player.setCredits(newCredits: player.getCredits() - 400)
                creditsLabel.text = "$\(player.getCredits())"
                peaceOptionButton.setTitle("Ok", for: .normal)
                combatOptionButton.isHidden = true
            }
        } else if (eventKey == "mercenary") {
            if(ship.getBlasters()) {
                encounterMessage.text = "You defeated the mercenary and found $200 on board!"
                player.setCredits(newCredits: player.getCredits() + 200)
                creditsLabel.text = "$\(player.getCredits())"
                peaceOptionButton.setTitle("Ok", for: .normal)
                combatOptionButton.isHidden = true
            } else {
                encounterMessage.text = "The mercenary defeated you and stole all of your goods!"
                ship.clearCargo()
                peaceOptionButton.setTitle("Ok", for: .normal)
                combatOptionButton.isHidden = true
            }
        }
        
    }
    
    // Close the menu so player can resume normal travel
    private func closeEventMenu() {
        encounterPopUpView.isHidden = true
        encounterImg.isHidden = true
    }
    
    // For traders, generates a random market item to trade
    public func randomTradeItem() -> MarketItem {
        var items: [MarketItem] = []
        
        items.append(MarketItem(good: Water(), quantity: Int.random(in: 1...5), price: Water().basePrice))
        items.append(MarketItem(good: Furs(), quantity: Int.random(in: 1...5), price: Furs().basePrice))
        items.append(MarketItem(good: Food(), quantity: Int.random(in: 1...5), price: Food().basePrice))
        items.append(MarketItem(good: Ore(), quantity: Int.random(in: 1...5), price: Ore().basePrice))
        items.append(MarketItem(good: Games(), quantity: Int.random(in: 1...5), price: Games().basePrice))
        items.append(MarketItem(good: Firearms(), quantity: Int.random(in: 1...5), price: Firearms().basePrice))
        items.append(MarketItem(good: Medicine(), quantity: Int.random(in: 1...5), price: Medicine().basePrice))
        items.append(MarketItem(good: Machines(), quantity: Int.random(in: 1...5), price: Machines().basePrice))
        items.append(MarketItem(good: Narcotics(), quantity: Int.random(in: 1...5), price: Narcotics().basePrice))
        items.append(MarketItem(good: Robots(), quantity: Int.random(in: 1...5), price: Robots().basePrice))
        
        let randIdx = Int.random(in: 0...items.count - 1)
        return items[randIdx]
    }
    
    
    //      SEGUE PREPERATION      //
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
