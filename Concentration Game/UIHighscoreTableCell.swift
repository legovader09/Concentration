//
//  UIHighscoreTableCell.swift
//  Concentration Game
//
//  Created by Dominik on 30/11/2020.
//  Copyright © 2020 Dominik Hauerstein - 201440296. All rights reserved.
//

import UIKit

class UIHighscoreTableCell: UITableViewCell {

    @IBOutlet var lblTurns: UILabel!
    @IBOutlet var lblMatches: UILabel!
    @IBOutlet var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
