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

class Planet {
    
    // ATTRIBUTES
    private var name: String
    private var location: (Int, Int)
    private var techLevel: TechLevel
    private var resource: Resource
    private var traderEncounterChance: Int
    private var policeEncoutnerChance: Int
    private var mercenaryEncoutnerChance: Int
    
    
    // INITIALIZER
    init() {
        name = chooseName(index: Int.random(in: 0...9))
        location = (Int.random(in: 0...100), Int.random(in: 0...200))
        techLevel = TechLevel(rawValue: Int.random(in: 0...7)) ?? TechLevel.PRE_AGRICULTURE
        resource = Resource.allCases.randomElement() ?? Resource.NON_SPECIAL_RESOURCES
        traderEncounterChance = techLevel.rawValue + 2
        policeEncoutnerChance = Int.random(in: 0...10)
        mercenaryEncoutnerChance = 10 - policeEncoutnerChance
    }
    
    
    // GETTERS
    public func getName() -> String { return name }
    public func getlocation() -> (Int, Int) { return location }
    public func getTechLevel() -> TechLevel { return techLevel }
    public func getResource() -> Resource { return resource }
    public func getTraderEC() -> Int { return traderEncounterChance }
    public func getPoliceEC() -> Int { return policeEncoutnerChance }
    public func getMercenaryEC() -> Int { return mercenaryEncoutnerChance }
}

private func chooseName(index: Int) -> String {
    let name = availableNames[index]
    availableNames.remove(at: index)
    return name
}
