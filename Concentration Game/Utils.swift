//
//  Utils.swift
//  Concentration Game
//
//  Created by Dominik on 26/11/2020.
//  Copyright © 2020 Dominik Hauerstein - 201440296. All rights reserved.
//

import Foundation
import UIKit

//Global vars

/// This struct stores, and loads all the user configurations.
struct config {
    static var cardBackChoice: String = configFile.string(forKey: "cardBackChoice") ?? "blue_back"
    static var P1Name: String = configFile.string(forKey: "p1Name") ?? "Player 1"
    static var P2Name: String = configFile.string(forKey: "p2Name") ?? "Player 2"
    
    static let storedScores = configFile.object(forKey: "highScore")
    
    static var highscore: [highscoreData] = []
}

/// This is the structure of how a singular highscore should look like. It is codable to make the struct serialisable.
struct highscoreData: Codable {
    var turns: Int
    var matches: Int
    var name: String
}

let configFile = UserDefaults.standard

var cardArray = ["A", "2" , "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
var cardColour = ["C", "D", "H", "S"]

//Global funcs

/// Randomly generates a card using one character from 2 arrays.
/// ```
/// var cardArray = ["A", "2" , "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
/// var cardColour = ["C", "D", "H", "S"]
/// ```
/// Picks one character index from each array above.
/// Example: `cardArray[0]` + `cardColour[1] = `AD` or Ace of Diamonds.
func generateRandomCard() -> String {
    return "\(cardArray[Int.random(in: 0..<cardArray.count)])\(cardColour[Int.random(in: 0..<cardColour.count)])"
    //picks, at random, one of each array which should always end up being a valid card.
}

///Generates the deck, includes duplication check logic and shuffle.
func createDeck() {
    Deck.removeAll(keepingCapacity: false) //clear deck before generating new one.
    var cardString: String = ""
    print("Deck Contents: (x2)")
    for _ in 0...14 {
        cardString = generateRandomCard()
        while (true) { //this ensures there are no duplicates in the deck.
            if (Deck.contains(cardString)) {
                cardString = generateRandomCard()
            }
            else {
                break
            }
        }
        Deck.append(cardString)
        Deck.append(cardString) //duplicate the card, so that there will always be pairs.
        print(cardString) //printing deck to check if there are any duplicates. (Should only show 15 cards, and each should be unique.
    }
    
    Deck.shuffle() //sets cards in random order, otherwise all pairs will be next to each other.
}

func loadHighscores() {
    if let loadedData = configFile.data(forKey: "highScore") {
        config.highscore = try! PropertyListDecoder().decode([highscoreData].self, from: loadedData) //de-serialises the data after loading it from UserDefaults, this makes it usable.
        print("Highscores loaded: \(config.highscore.count)")
    }
}

/// Saves card back choice to UserDefaults config.
func saveConfig() {
    configFile.set(config.cardBackChoice, forKey:"cardBackChoice")
    configFile.set(config.P1Name, forKey:"p1Name")
    configFile.set(config.P2Name, forKey:"p2Name")
    
    let scoreData = try! PropertyListEncoder().encode(config.highscore) //saves highscore as Data object,
    configFile.set(scoreData, forKey:"highScore") //so that it can be stored in UserDefaults.
}
