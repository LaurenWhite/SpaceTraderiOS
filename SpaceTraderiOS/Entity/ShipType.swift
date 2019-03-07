//
//  ShipType.swift
//  SpaceTraderiOS
//
//  Created by Lauren White on 3/4/19.
//  Copyright © 2019 Lauren White. All rights reserved.
//

import Foundation

protocol ShipType {
    var name: String { get }
    var mileage: Int { get } // parsecs per gallon
    var fuelCapacity: Double { get }
    var cargoCapacity: Int { get }
    var basePrice: Int { get }
}

class Gnat: ShipType {
    var name = "Gnat"
    var mileage = 250
    var fuelCapacity = 8.0
    var cargoCapacity = 10
    var basePrice = 500
}

class Beetle: ShipType {
    var name = "Beetle"
    var mileage = 500
    var fuelCapacity = 15.0
    var cargoCapacity = 30
    var basePrice = 1500
}

class Wasp: ShipType {
    var name = "Wasp"
    var mileage = 1000
    var fuelCapacity = 20.0
    var cargoCapacity = 60
    var basePrice = 2500
}
