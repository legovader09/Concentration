//
//  Player.swift
//  Concentration Game
//
//  Created by Dominik on 30/11/2020.
//  Copyright © 2020 Dominik Hauerstein - 201440296. All rights reserved.
//

import Foundation

/// Player class used in Game class.
class Player: Equatable {
    
    /// Compares if both players are classed as main player, in which case they would be equal.
    static func == (lhs: Player, rhs: Player) -> Bool { //made class equatable to allow comparison.
        if lhs.isMainPlayer && rhs.isMainPlayer {
            return true
        }
        return false
    }
    
    var name = "Player 1"
    var currentTurn: Int = 1
    var currentMatches: Int = 0
    var isMainPlayer: Bool = false //only player 1 should be main player.
}
