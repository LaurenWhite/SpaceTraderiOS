//
//  Player.swift
//  SpaceTraderiOS
//
//  Created by Lauren White on 2/22/19.
//  Copyright © 2019 Lauren White. All rights reserved.
//

import Foundation

class Player {
    
    private var name: String
    
    private var availableSkillPoints: Int
    private var pilotPoints: Int
    private var fighterPoints: Int
    private var traderPoints: Int
    private var engineerPoints: Int
    
    private var credits: Int
    
    private var spaceship: Ship
    
    init() {
        name = "Name"
        availableSkillPoints = 16
        pilotPoints = 0
        fighterPoints = 0
        traderPoints = 0
        engineerPoints = 0
        credits = 1000
        spaceship = Ship()
    }
    
    public func getName() -> String { return name }
    public func getAvailableSkillPoints() -> Int { return availableSkillPoints }
    public func getPilotPoints() -> Int { return pilotPoints }
    public func getFighterPoints() -> Int { return fighterPoints }
    public func getTraderPoints() -> Int { return traderPoints }
    public func getEngineerPoints() -> Int { return engineerPoints }
    public func getCredits() -> Int { return credits }
    public func getSpaceship() -> Ship { return spaceship }
    
    public func setName(newName: String) { name = newName }
    public func setAvailableSkillPoints(newPoints: Int) { availableSkillPoints = newPoints }
    public func setPilotPoints(newPoints: Int) { pilotPoints = newPoints }
    public func setFighterPoints(newPoints: Int) { fighterPoints = newPoints }
    public func setTraderPoints(newPoints: Int) { traderPoints = newPoints }
    public func setEngineerPoints(newPoints: Int) { engineerPoints = newPoints }
    public func setCredits(newCredits: Int) { credits = newCredits }
    public func setSpaceShip(newSpaceship: Ship) { spaceship = newSpaceship }
    
    public func hasSufficientFunds(cost: Int) -> Bool {
        return credits >= cost
    }
}
