//
//  GameDatabase.swift
//  SpaceTraderiOS
//
//  Created by Lauren White on 4/22/19.
//  Copyright © 2019 Lauren White. All rights reserved.
//

import Foundation

var database = GameDatabase()
let gameKey = "games.key"

class GameDatabase {
    func saveGame() {
        //let gameData: [String:Any] = ["player" : player, "difficulty" : game.getDifficulty(), "planets": game.getPlanets()]
        let gameData: [String:Any] = ["player" : player, "game": game]
        UserDefaults.standard.set(gameData, forKey: gameKey)
    }
    
    
    func loadGame() {
        let savedData = UserDefaults.standard.array(forKey: gameKey) as? [[String:Any]] ?? []
        
//        for gameData in savedData {
//            if let loadedPlayer = gameData["player"] as? Player,
//                let loadedDiff = gameData["difficulty"] as? String,
//                let loadedPlanets = gameData["planets"] as? [Planet] {
//                player = loadedPlayer
//                game.setDifficulty(newDifficulty: loadedDiff)
//                game.setPlanets(newPlanets: loadedPlanets)
//            }
        //}
    }
}


