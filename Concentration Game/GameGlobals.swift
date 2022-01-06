//
//  This class stores all the global variables that the game will access.
//  Concentration Game
//
//  Created by Dominik on 29/11/2020.
//  Copyright © 2020 Dominik Hauerstein - 201440296. All rights reserved.
//

import Foundation

var Game1 = Game()
var Deck = [String]()


class Game {
    var player1: Player? = Player()
    var player2: Player? = nil
    var nobody: Player? = Player() //placeholder player
    private(set) var maxTurns: Int = 30 //30 for singleplayer, 15 each for multiplayer
    var matchesFoundInGame: Int = 0
    private(set) var currentPlayer: Player? = nil
    private(set) var winner: Player? = nil
    
    /// Initialises the game, getting everything ready to play.
    ///
    /// - parameter multiplayer: Takes a boolean value to determine whether the game should be a multiplayer or singleplayer game.
    /// - parameter maxTurns: *(Optional) The maximum amount of turns, this shouldn't be changed, but can be used for debugging sake. (Default = 30)*
    /// - parameter player1name: *(Optional) The name for Player 1. (Default = "Player 1")*
    /// - parameter player2name: *(Optional) The name for Player 2. (Default = "Player 2")*
    func initialise(multiplayer: Bool, maxTurns: Int = 30, player1name: String = "Player 1", player2name: String = "Player 2") {
        
        self.maxTurns = maxTurns
        
        if (multiplayer) {
            player2 = Player()
            player2?.name = player2name
            nobody?.name = "nobody"
        }
        else {
            player2 = nil
        }
        player1?.name = player1name
        player1?.isMainPlayer = true
        
        currentPlayer = player1
    }
    
    /// Increments turn counter for current player, and checks  if max turns has been exceeded.
    /// - Tag: toggleTurn
    func toggleTurn() {
        if (getTotalElapsedTurns() >= maxTurns) {
            winner = endGameAndGetWinner()
        }
        currentPlayer?.currentTurn += 1
        currentPlayer = getUpcomingPlayer()
    }
    
    /// Returns the upcoming player.
    /// - returns: `Player()` objectt.
    func getUpcomingPlayer() -> Player? {
        if (isMultiplayer()) {
            return (currentPlayer == player1) ? player2 : player1 //if currentplayer is player1, then next is player 2.
        }
        else {
            return player1
        }
    }
    
    /// Adds +1 to the current player's matches, and updates the total matches found in game.
    func addMatchFound() {
        currentPlayer?.currentMatches += 1
        matchesFoundInGame += 1
        if (matchesFoundInGame == 15) {//half the number of cards in a deck.
            winner = endGameAndGetWinner()
        }
    }
    
    /// Returns the sum of total turns taken by both players.
    func getTotalElapsedTurns() -> Int {
        return player1!.currentTurn + (player2?.currentTurn ?? 0)
    }
    
    /// Returns true if game is a multiplayer game, and false if not.
    public func isMultiplayer() -> Bool {
        return player2 != nil
    }
    
    /// Ends the game and declares a winner.
    /// - warning: If both players tie, this function returns "nobody" as Player object.
    private func endGameAndGetWinner() -> Player? {
        if (player1!.currentMatches > 0) { //if the player matched any cards.
            config.highscore.append(highscoreData(turns: player1!.currentTurn, matches: player1!.currentMatches, name: player1!.name)) //player 1 score
            saveConfig()
        }
        if (isMultiplayer()) {
            if (player2!.currentMatches > 0) {
                config.highscore.append(highscoreData(turns: player2!.currentTurn, matches: player2!.currentMatches, name: player2!.name)) //player 2 score
                saveConfig()
            }
            if (player1!.currentMatches == player2!.currentMatches) {
                return nobody //this means tie.
            }
            else {
                return player1!.currentMatches >= player2!.currentMatches ? player1 : player2 //returns player with most matches.
            }
        }
        else {
            return currentPlayer //return currentplayer which in this instance will always be player1
        }
    }
}
