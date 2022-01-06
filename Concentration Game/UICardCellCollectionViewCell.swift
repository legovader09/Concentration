//
//  UICardCellCollectionViewCell.swift
//  Concentration Game
//
//  Created by Dominik on 26/11/2020.
//  Copyright © 2020 Dominik Hauerstein - 201440296. All rights reserved.
//

import UIKit

class UICardCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var cardImage: UIImageView!
    var cardType: String = ""
    var isPressed: Bool = false
    var isMatched: Bool = false
}
