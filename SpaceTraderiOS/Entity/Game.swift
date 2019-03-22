//
//  Game.swift
//  SpaceTraderiOS
//
//  Created by Lauren White on 2/27/19.
//  Copyright © 2019 Lauren White. All rights reserved.
//

import Foundation

var game: Game = loadGame() ?? Game()

class Game {
    
    // ATTRIBUTES
    private let planets: [Planet]
    private var difficulty: String
    
    
    // INTIALIZER
    init() {
        difficulty = "Beginner"
        planets = generatePlanets()
        printPlanets(planets: planets)
    }
    
    
    // GETTERS
    public func getPlanets() -> [Planet] { return planets }
    public func getDifficulty() -> String { return difficulty }
}



// HELPER FUNCTIONS
private func generatePlanets() -> [Planet] {
    var newPlanets: [Planet] = []
    for _ in 1...10 {
        newPlanets.append(Planet())
    }
    return newPlanets
}

private func printPlanets(planets: [Planet]) {
    for planet in planets {
        print(planet.getName() + " \(planet.getLocation())" + " TL:\(planet.getTechLevel())" + " R:\(planet.getResource())")
    }
}

private func loadGame() -> Game? {
    return nil
}
