//
//  MeteorCell.swift
//  NASA-Meteors
//
//  Created by Daniel Farrell on 02/03/2020.
//  Copyright © 2020 Daniel Farrell. All rights reserved.
//

import UIKit

class MeteorCell: UITableViewCell {

    @IBOutlet var meteorBackgroundView: UIView!
    @IBOutlet var meteorImageView: UIImageView!
    @IBOutlet var meteorNameLabel: UILabel!
    @IBOutlet var meteorDateLabel: UILabel!
    @IBOutlet var meteorMassLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        meteorBackgroundView.layer.cornerRadius = 15
    }

}
