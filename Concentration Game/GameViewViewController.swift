//
//  GameViewViewController.swift
//  Concentration Game
//
//  Created by Dominik on 24/11/2020.
//  Copyright © 2020 Dominik Hauerstein - 201440296. All rights reserved.
//

import UIKit

class GameViewViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: Init variables and functions.
    
    @IBOutlet var UIPlayingOutlet: UICollectionView!
    @IBOutlet var btnQuit: UIButton!
    @IBOutlet var lblCurrentPlayer: UILabel!
    @IBOutlet var lblNextPlayer: UILabel!
    @IBOutlet var lblTurnCounter: UILabel!
    @IBOutlet var lblMatchesFound: UILabel!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 65, height: 115)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let card = UIPlayingOutlet.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! UICardCellCollectionViewCell
        card.cardImage.image = UIImage(named: config.cardBackChoice)
        card.cardType = Deck[indexPath.item]
        
        return card
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateGameUI()
    }
    
    // MARK: End of Init.
    
    @IBAction func showAlertButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Quit Game", message: "Are you sure you want to quit?", preferredStyle: UIAlertController.Style.alert) //show prompt asking user if they really want to quit, instead of just closing the game right away.

        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) in
            self.dismiss(animated: true, completion: nil) //close the game.
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil)) //placeholder option, needs no action as this will just close the dialog.

        self.present(alert, animated: true, completion: nil)
    }
    
    var pressesThisTurn: Int = 0
    var selectCard1: UICardCellCollectionViewCell? = nil
    var lockUI: Bool = false
    
    
    // MARK: All the main logic happens here. In this method.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let card = collectionView.cellForItem(at: indexPath) as! UICardCellCollectionViewCell
        if (!lockUI && !card.isMatched) { //only if UI is unlocked, and the card isn't already a match will this trigger.
            card.isPressed = true
            card.isUserInteractionEnabled = false
            card.cardImage.image = UIImage(named: card.cardType) //sets card to relative card image from assets.
            pressesThisTurn += 1 //counts how many cards user pressed.
            
            if (pressesThisTurn == 1) {
                selectCard1 = card //set current cell reference to another variable for later use.
            }
            else if (pressesThisTurn == 2) {
                lockUI = true //lock up UI so user can't press another card while matching process is happening.
                if (selectCard1?.cardType == card.cardType) { //if card type matches.
                    selectCard1?.isMatched = true //indicates that the 2 pairs have now matched.
                    card.isMatched = true
                    Game1.addMatchFound() //update the match count.
                    updateGameUI() //manual call to update game UI to show immediate success if user finds a match
                }
                else { //if no match, turns cards around.
                    let seconds = 1.2
                    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { // dispatch queue used to delay hiding the cards.
                        card.cardImage.image = UIImage(named: config.cardBackChoice)
                        card.isPressed = false
                        card.isUserInteractionEnabled = true //re-enable interaction so that the user can press this card again.
                        self.selectCard1?.cardImage.image = UIImage(named: config.cardBackChoice)
                        self.selectCard1?.isPressed = false
                        self.selectCard1?.isUserInteractionEnabled = true
                    }
                }
                let seconds = 1.3 //delay used to give a small pause before allowing the user to interact with the board again.
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.pressesThisTurn = 0
                    self.advanceTurn()
                }
            }
        }
    }
    
    /// Updates the interface of the game to display the current user's stats.
    func updateGameUI() {
        lblTurnCounter.text = "\(Game1.currentPlayer!.currentTurn)/\(Game1.isMultiplayer() ? Game1.maxTurns / 2 : Game1.maxTurns)" //set max turns to 15 if multiplayer, 30 if singleplayer.
        lblMatchesFound.text = String(Game1.currentPlayer!.currentMatches)
        
        lblCurrentPlayer.text = Game1.currentPlayer?.name //update current player to show to user.
        lblCurrentPlayer.textAlignment = NSTextAlignment.right
        
        lblNextPlayer.text = (Game1.isMultiplayer()) ? Game1.getUpcomingPlayer()?.name : "Single Player" //update upcoming player, but keep text as singleplayer, if that's the gamemode.
        lblNextPlayer.textAlignment = NSTextAlignment.right
    }
    
    /// Updates the UI and calls the [turn change event](x-source-tag://toggleTurn) from the Game class.
    func advanceTurn() {
        Game1.toggleTurn()
        updateGameUI()
        if (Game1.winner == nil) { //if there isnt a winner yet, keep playing
            self.lockUI = false
        }
        else {
            let alert = UIAlertController(title: "Game Finished!", message: "The winner is \( Game1.winner!.name)!", preferredStyle: UIAlertController.Style.alert) //creates winner alert.

            alert.addAction(UIAlertAction(title: "Exit to Main Menu", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) in
                self.dismiss(animated: true, completion: nil) //action to go back to main menu
            }))

            self.present(alert, animated: true, completion: nil) //show alert to user.
        }
    }
}
