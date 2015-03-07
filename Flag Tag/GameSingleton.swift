//
//  GameSingleton.swift
//  Flag Tag
//
//  Created by Ebony Nyenya and Bobby Towers on 3/7/15.
//  Copyright (c) 2015 Ebony Nyenya and Bobby Towers. All rights reserved.
//

// GameSingleton.gameData().mixPlayers

import UIKit

// Create GameSingleton object
let _gameData: GameSingleton = GameSingleton()

class GameSingleton: NSObject {
    
    ///// GAME PROPERTIES
    
    let minPlayers = 2
    let maxPlayers = 10
    var actviePlayers = 0
    
    // Overall game time limit = 30 min (make dynamic later)
    var timeLimit = 1800
    var timeCount = 0
    var timer = NSTimer()
    var timerIsActive = false
    
    var gameIsActive = false
    
    // 1 mile radius (make dynamic later)
    var geoFence = 1.0
    
    
    
    
    // Return GameSingleton
    class func gameData() -> GameSingleton {
        
        return _gameData
    }
    
    func startGameClock() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("timerIncrement"), userInfo: nil, repeats: true)
        timerIsActive = true
    }
    
    func timerIncrement() {
        timeCount++
    }
}

