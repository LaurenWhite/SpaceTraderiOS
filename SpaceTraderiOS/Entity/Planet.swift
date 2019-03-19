//
//  Planet.swift
//  SpaceTraderiOS
//
//  Created by Lauren White on 2/27/19.
//  Copyright © 2019 Lauren White. All rights reserved.
//

import Foundation

var availableNames = ["Nix", "Morag", "Xena", "Nobiru", "Vesperia", "Xillia", "Ventus",
                      "Lapis", "Altair", "Zeno"]

var existingCoordinates: [(Int, Int)] = []
var counter: Int = 0

class Planet {
    
    // ATTRIBUTES
    private var name: String
    private var location: (Int, Int)
    private var techLevel: TechLevel
    private var resource: Resource
    private var market: [MarketItem]
    private var traderEncounterChance: Int
    private var policeEncoutnerChance: Int
    private var mercenaryEncoutnerChance: Int
    
    
    // INITIALIZER
    init() {
       
        name = chooseName(index: Int.random(in: 0..<availableNames.count))
        location = generateLocation()
        print("Location " + String(counter) + " generated!")
        techLevel = TechLevel(rawValue: Int.random(in: 0...7)) ?? TechLevel.PRE_AGRICULTURE
        resource = Resource.allCases.randomElement() ?? Resource.NON_SPECIAL_RESOURCES
        market = generateMarket(techLevelVal: techLevel.rawValue)
        traderEncounterChance = techLevel.rawValue + 2
        policeEncoutnerChance = Int.random(in: 0...10)
        mercenaryEncoutnerChance = 10 - policeEncoutnerChance
        print("Planet Point " + String(counter))
        counter += 1
    }
    
    
    // GETTERS
    public func getName() -> String { return name }
    public func getLocation() -> (Int, Int) { return location }
    public func getTechLevel() -> TechLevel { return techLevel }
    public func getResource() -> Resource { return resource }
    public func getMarket() -> [MarketItem] { return market }
    public func getTraderEC() -> Int { return traderEncounterChance }
    public func getPoliceEC() -> Int { return policeEncoutnerChance }
    public func getMercenaryEC() -> Int { return mercenaryEncoutnerChance }
}

private func chooseName(index: Int) -> String {
    let name = availableNames[index]
    availableNames.remove(at: index)
    return name
}

private func generateLocation() -> (Int, Int) {
    var randomLocation = (Int.random(in: 50...360), Int.random(in: 50...760))
    
    while(hasOverlap(testLocation: randomLocation)) {
        randomLocation = (Int.random(in: 50...360), Int.random(in: 50...760))
    }
    existingCoordinates.append(randomLocation)
    return randomLocation
}

private func hasOverlap(testLocation: (Int, Int)) -> Bool {
    for coordinate in existingCoordinates {
        if(abs(testLocation.0 - coordinate.0) < 25) {
            return true
        }
        if(abs(testLocation.1 - coordinate.1) < 25) {
            return true
        }
    }
    return false
}

private func generateMarket(techLevelVal: Int) -> [MarketItem] {
    var items: [MarketItem] = []
    
    items.append(MarketItem(good: Water(), techLevelVal: techLevelVal))
    items.append(MarketItem(good: Furs(), techLevelVal: techLevelVal))
    items.append(MarketItem(good: Food(), techLevelVal: techLevelVal))
    items.append(MarketItem(good: Ore(), techLevelVal: techLevelVal))
    items.append(MarketItem(good: Games(), techLevelVal: techLevelVal))
    items.append(MarketItem(good: Firearms(), techLevelVal: techLevelVal))
    items.append(MarketItem(good: Medicine(), techLevelVal: techLevelVal))
    items.append(MarketItem(good: Machines(), techLevelVal: techLevelVal))
    items.append(MarketItem(good: Narcotics(), techLevelVal: techLevelVal))
    items.append(MarketItem(good: Robots(), techLevelVal: techLevelVal))
    
    var market = [MarketItem]()
    for item in items {
        if item.quantity != 0 { market.append(item) }
    }
    
    return market
}
