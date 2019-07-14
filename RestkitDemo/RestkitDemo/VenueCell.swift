//
//  VenueCell.swift
//  RestkitDemo
//
//  Created by Kirti Parghi on 7/14/19.
//  Copyright © 2019 Kirti Parghi. All rights reserved.
//

import UIKit

class VenueCell: UITableViewCell {

    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var distanceLabel:UILabel!
    @IBOutlet weak var checkinsLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
