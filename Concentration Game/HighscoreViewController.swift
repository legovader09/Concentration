//
//  HighscoreViewController.swift
//  Concentration Game
//
//  Created by Dominik on 30/11/2020.
//  Copyright © 2020 Dominik Hauerstein - 201440296. All rights reserved.
//

import UIKit

class HighscoreViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return config.highscore.count //number of rows = number of highscores.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath) as! UIHighscoreTableCell
       
        let score = config.highscore
        let index = score.count - indexPath.row - 1 //this will sort data such that the newest data will stay at the top.
                   
        cell.lblTurns.text = "Turns: \(score[index].turns)"
        cell.lblMatches.text = "Matches: \(score[index].matches)"
        cell.lblName.text = score[index].name
       
        return cell
    }
}
