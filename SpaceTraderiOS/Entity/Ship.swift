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
    private var cargo: [MarketItem]
    private var fuel: Double

    
    //      INITIALIZER     //
    init() {
        type = Gnat()
        currentLocation = (0,0)
        fuel = type.fuelCapacity
        cargo = [
            MarketItem(good: Water(), techLevelVal: 3),
            MarketItem(good: Ore(), techLevelVal: 4),
            MarketItem(good: Robots(), techLevelVal: 7)
        ]
    }
    
    
    //      GETTERS     //
    public func getType() -> ShipType { return type }
    public func getCurrentLocation() -> (Int, Int) { return currentLocation }
    public func getFuel() -> Double { return fuel }
    public func getFuelCapacity() -> Double { return type.fuelCapacity }
    public func getMileage() -> Int { return type.mileage }
    public func getCargo() -> [MarketItem] { return cargo }
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
    private var currentWeight: Int {
        var sum = 0
        for item in cargo {
            sum += item.good.weight
        }
        return sum
    }
    
    public func hasSufficientSpace(newWeight: Int) -> Bool {
        return currentWeight + newWeight <= type.cargoCapacity
    }
    
    public func addToCargo(newItem: MarketItem) {
        if cargo.contains(newItem) {
            let index = cargo.firstIndex(of: newItem)!
            cargo[index].quantity += newItem.quantity
            cargo[index].price = newItem.price
        } else {
            cargo.append(newItem)
        }
    }
    
    public func removeFromCargo(item: MarketItem) {
        guard cargo.contains(item) else { return }
        let index = cargo.firstIndex(of: item)!
        
        if(item.quantity == cargo[index].quantity) {
            cargo.remove(at: index)
        } else {
            cargo[index].quantity -= item.quantity
        }
    }
    
    public func updateRegionalPrices(planet: Planet) {
        for item in planet.getMarket() {
            if cargo.contains(item) {
                let index = cargo.firstIndex(of: item)!
                cargo[index].price = item.price
            }
        }
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
