//
//  Ship.swift
//  SpaceTraderiOS
//
//  Created by Lauren White on 2/28/19.
//  Copyright © 2019 Lauren White. All rights reserved.
//

import Foundation

class Ship {
    
    //      ATTRIBUTES      //
    private var type: ShipType
    private var currentLocation: (Int, Int)
    private var cargo: [String]
    private var fuel: Double

    
    //      INITIALIZER     //
    init() {
        type = Gnat()
        currentLocation = (0,0)
        fuel = type.fuelCapacity
        cargo = []
    }
    
    
    //      GETTERS     //
    public func getType() -> ShipType { return type }
    public func getCurrentLocation() -> (Int, Int) { return currentLocation }
    public func getFuel() -> Double { return fuel }
    public func getFuelCapacity() -> Double { return type.fuelCapacity }
    public func getMileage() -> Int { return type.mileage }
    public func getCargo() -> [String] { return cargo }
    public func getCargoCapacity() -> Int { return type.cargoCapacity }
    
    
    //      SETTERS     //
    public func setCurrentLocation(newLocation: (Int, Int)) { currentLocation = newLocation }
    
    
    //      TRAVEL FUNCTIONS      //
    public func travel(distance: Double, fuelNeeded: Double) {
        
        print("Distance: \(distance) parsecs")
        print("Fuel Used: \(fuelNeeded) gallons")
        
        fuel -= fuelNeeded
    }
    
    public func calculateDistance(newDestination: (Int, Int)) -> Double {
        let (x0, y0) = currentLocation
        let (x, y) = newDestination
        
        let distance: Double = sqrt(pow(Double(x - x0), 2) + pow(Double(y - y0), 2))
        return Double(distance.rounded(toPlaces: 2))
    }
    
    public func calculateFuelNeeded(distance: Double) -> Double {
        print("RESULT: \((distance / Double(type.mileage)).rounded(toPlaces: 3))")
        return (distance / Double(type.mileage)).rounded(toPlaces: 3)
    }
    
    
    //      CARGO FUNCTIONS     //
    // ...
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
