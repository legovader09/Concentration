//
//  ViewController.swift
//  Concentration Game
//
//  Created by Dominik on 24/11/2020.
//  Copyright © 2020 Dominik Hauerstein - 201440296. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var singlePlayer: UIButton!
    @IBOutlet var multiPlayer: UIButton!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if !(sender == singlePlayer || sender == multiPlayer) { //filter out other buttons.
            return
        }
        createDeck() //generates a new deck before starting the game.
        Game1 = Game()
        Game1.initialise(multiplayer: (sender == multiPlayer), player1name: config.P1Name, player2name: config.P2Name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadHighscores()
    }
}

