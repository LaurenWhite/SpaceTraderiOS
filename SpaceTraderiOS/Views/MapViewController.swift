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
    
    //      VARIABLES       //
    var planets = game.getPlanets()
    
    // Planet text keys for passing info
    var planetImgKey: String? = nil
    var newKey: String = ""
    
    // Planet name text for passing info
    var selectedPlanetName: String = ""
    var currentPlanetName: String? = ""
    
    // Target destination
    var selectedDestination: (Int, Int) = (0,0)
    
    // General ship and travel info
    var ship = player.getSpaceship()
    var fuelNeeded: Double = 0
    var distance: Double = 0
    
    // Event chance info
    var eventChances: [String : Int] = [:]
    
    
    //      UI OUTLETS      //
    
    // Images for planets
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
    
    // Pop up message box and features
    @IBOutlet var travelPopUpView: DesignableView!
    @IBOutlet var confirmationTextView: UITextView!
    @IBOutlet var yesButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        travelPopUpView.isHidden = true
        updateConfirmationMessage()
        setImages()
        displayAtLocation()
    }
    
    
    //      GENERAL MAP SCREEN FUNCTIONS       //
    
    @IBAction func backButtonSelected(_ sender: Any) {
        guard travelPopUpView.isHidden else { return }
        self.performSegue(withIdentifier: "maptomain", sender: nil)
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
        planet1Img.frame = CGRect(x: planets[0].getLocation().0,
                                  y: planets[0].getLocation().1,
                                  width: 50, height: 50)
        planet2Img.frame = CGRect(x: planets[1].getLocation().0,
                                  y: planets[1].getLocation().1,
                                  width: 50, height: 50)
        planet3Img.frame = CGRect(x: planets[2].getLocation().0,
                                  y: planets[2].getLocation().1,
                                  width: 50, height: 50)
        planet4Img.frame = CGRect(x: planets[3].getLocation().0,
                                  y: planets[3].getLocation().1,
                                  width: 50, height: 50)
        planet5Img.frame = CGRect(x: planets[4].getLocation().0,
                                  y: planets[4].getLocation().1,
                                  width: 50, height: 50)
        planet6Img.frame = CGRect(x: planets[5].getLocation().0,
                                  y: planets[5].getLocation().1,
                                  width: 50, height: 50)
        planet7Img.frame = CGRect(x: planets[6].getLocation().0,
                                  y: planets[6].getLocation().1,
                                  width: 50, height: 50)
        planet8Img.frame = CGRect(x: planets[7].getLocation().0,
                                  y: planets[7].getLocation().1,
                                  width: 50, height: 50)
        planet9Img.frame = CGRect(x: planets[8].getLocation().0,
                                  y: planets[8].getLocation().1,
                                  width: 50, height: 50)
        planet10Img.frame = CGRect(x: planets[9].getLocation().0,
                                   y: planets[9].getLocation().1,
                                   width: 50, height: 50)
    }
    
    @IBAction func p1Selected(_ sender: Any) {
        newKey = "planet01"
        updateSelectedInfo(indx: 0)
        distance = ship.calculateDistance(newDestination: selectedDestination)
        fuelNeeded = ship.calculateFuelNeeded(distance: distance)
        updateConfirmationMessage()
        travelPopUpView.isHidden = false
    }
    
    @IBAction func p2Selected(_ sender: Any) {
        newKey = "planet02"
        updateSelectedInfo(indx: 1)
        distance = ship.calculateDistance(newDestination: selectedDestination)
        fuelNeeded = ship.calculateFuelNeeded(distance: distance)
        updateConfirmationMessage()
        travelPopUpView.isHidden = false
    }
    
    @IBAction func p3Selected(_ sender: Any) {
        newKey = "planet03"
        updateSelectedInfo(indx: 2)
        distance = ship.calculateDistance(newDestination: selectedDestination)
        fuelNeeded = ship.calculateFuelNeeded(distance: distance)
        updateConfirmationMessage()
        travelPopUpView.isHidden = false
    }
    
    @IBAction func p4Selected(_ sender: Any) {
        newKey = "planet04"
        updateSelectedInfo(indx: 3)
        distance = ship.calculateDistance(newDestination: selectedDestination)
        fuelNeeded = ship.calculateFuelNeeded(distance: distance)
        updateConfirmationMessage()
        travelPopUpView.isHidden = false
    }
    
    @IBAction func p5Selected(_ sender: Any) {
        newKey = "planet05"
        updateSelectedInfo(indx: 4)
        distance = ship.calculateDistance(newDestination: selectedDestination)
        fuelNeeded = ship.calculateFuelNeeded(distance: distance)
        updateConfirmationMessage()
        travelPopUpView.isHidden = false
    }
    
    @IBAction func p6Selected(_ sender: Any) {
        newKey = "planet06"
        updateSelectedInfo(indx: 5)
        distance = ship.calculateDistance(newDestination: selectedDestination)
        fuelNeeded = ship.calculateFuelNeeded(distance: distance)
        updateConfirmationMessage()
        travelPopUpView.isHidden = false
    }
    
    @IBAction func p7Selected(_ sender: Any) {
        newKey = "planet07"
        updateSelectedInfo(indx: 6)
        distance = ship.calculateDistance(newDestination: selectedDestination)
        fuelNeeded = ship.calculateFuelNeeded(distance: distance)
        updateConfirmationMessage()
        travelPopUpView.isHidden = false
    }
    
    @IBAction func p8Selected(_ sender: Any) {
        newKey = "planet08"
        updateSelectedInfo(indx: 7)
        distance = ship.calculateDistance(newDestination: selectedDestination)
        fuelNeeded = ship.calculateFuelNeeded(distance: distance)
        updateConfirmationMessage()
        travelPopUpView.isHidden = false
    }
    
    @IBAction func p9Selected(_ sender: Any) {
        newKey = "planet09"
        updateSelectedInfo(indx: 8)
        distance = ship.calculateDistance(newDestination: selectedDestination)
        fuelNeeded = ship.calculateFuelNeeded(distance: distance)
        updateConfirmationMessage()
        travelPopUpView.isHidden = false
    }
    
    @IBAction func p10Selected(_ sender: Any) {
        newKey = "planet10"
        updateSelectedInfo(indx: 9)
        distance = ship.calculateDistance(newDestination: selectedDestination)
        fuelNeeded = ship.calculateFuelNeeded(distance: distance)
        updateConfirmationMessage()
        travelPopUpView.isHidden = false
        
    }
    
    private func updateSelectedInfo(indx: Int) {
        let planet = planets[indx]
        selectedPlanetName = planet.getName()
        selectedDestination = planet.getLocation()
        eventChances["trader"] = planet.getTraderEC()
        eventChances["police"] = planet.getPoliceEC()
        eventChances["mercenary"] = planet.getMercenaryEC()
    }
    
    
    //      POP UP WINDOW FUNCTIONS       //
    
    private func updateConfirmationMessage() {
        confirmationTextView.text = "Confirmation: Travel to \(selectedPlanetName) for \(distance) parsecs using \(fuelNeeded) gallons of fuel?"
        yesButton.isHidden = false
    }
    
    private func showInsufficientFuelMessage() {
        confirmationTextView.text = "You do not have enough fuel to travel to this planet."
        yesButton.isHidden = true
    }
    
    @IBAction func confrimTravelSelected(_ sender: Any) {
        // Check if you have enough fuel
        guard fuelNeeded <= ship.getFuel() else {
            showInsufficientFuelMessage()
            travelPopUpView.isHidden = false
            return
        }
        ship.travel(distance: distance, fuelNeeded: fuelNeeded)
        planetImgKey = newKey
        print("From: \(currentPlanetName)")
        currentPlanetName = selectedPlanetName
        print("To: \(currentPlanetName)")
        ship.setCurrentLocation(newLocation: selectedDestination)
        self.performSegue(withIdentifier: "maptomain", sender: nil)
    }
    
    @IBAction func cancelTravelSelected(_ sender: Any) {
        travelPopUpView.isHidden = true
    }
    
    
    
    //      SEGUE PREPERATION      //
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MainScreenViewController {
            destination.planetImgKey = planetImgKey
            destination.planetName = currentPlanetName
            destination.eventChances = eventChances
        }
    }
}
