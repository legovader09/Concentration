//
//  Settings.swift
//  Concentration Game
//
//  Created by Dominik on 27/11/2020.
//  Copyright © 2020 Dominik Hauerstein - 201440296. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var blue_back: UIImageView!
    @IBOutlet var purple_back: UIImageView!
    @IBOutlet var green_back: UIImageView!
    @IBOutlet var gray_back: UIImageView!
    @IBOutlet var yellow_back: UIImageView!
    @IBOutlet var red_back: UIImageView!
    
    @IBOutlet var txtP1: UITextField!
    @IBOutlet var txtP2: UITextField!
    
    @IBOutlet var selectedLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        blue_back.image = UIImage(named: "blue_back")
        purple_back.image = UIImage(named: "purple_back")
        green_back.image = UIImage(named: "green_back")
        gray_back.image = UIImage(named: "gray_back")
        yellow_back.image = UIImage(named: "yellow_back")
        red_back.image = UIImage(named: "red_back")
        
        selectedLbl.text = "Currently Selected: \(config.cardBackChoice)"
        txtP1.text = config.P1Name
        txtP2.text = config.P2Name
    }
    
    /// Update config after one of the text fields in settings has been updated.
    @IBAction func txtEditDone(_ sender: UITextField, forEvent event: UIEvent) {
        config.P1Name = txtP1.text ?? "Player 1"
        config.P2Name = txtP2.text ?? "Player 2"
        saveConfig()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if let t = touches.first {
            if (t.view is UIImageView) {
                config.cardBackChoice = "\(t.view!.accessibilityIdentifier ?? "blue_back")" //identifiers are set to each colours name which is the same as resource file.
                saveConfig()
            }
        }
        selectedLbl.text = "Currently Selected: \(config.cardBackChoice)" //updates currently selected label to let the user know something happened.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
