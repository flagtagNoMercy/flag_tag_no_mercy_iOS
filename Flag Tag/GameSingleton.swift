//
//  GameSingleton.swift
//  Flag Tag
//
//  Created by Ebony Nyenya and Bobby Towers on 3/7/15.
//  Copyright (c) 2015 Ebony Nyenya and Bobby Towers. All rights reserved.
//

// GameSingleton.gameData().maxPlayers

import UIKit

// Create GameSingleton object
let _gameData: GameSingleton = GameSingleton()

class GameSingleton: NSObject {
    
    ///// GAME PROPERTIES
    
    let minPlayers = 2
    let maxPlayers = 10
    var activePlayers = 0
    
    var activePlayerArray = [Player]()
    
    var leaderPoints = 0
    
    // Overall game time limit = 30 min (make dynamic later)
    var timeLimit = 60
    
    var gameIsActive = false
    
    // 1 mile radius (make dynamic later)
    var geoFence = 1.0
    
    
    
    
    // Return GameSingleton
    class func gameData() -> GameSingleton {
        
        return _gameData
    }
    
    func playerJoinsGame() {
        
    }
    
    func determineLeader() {
        
    }
}