//
//  AddContactTableViewCell.swift
//  Brnch
//
//  Created by Amritha Prasad on 6/18/15.
//  Copyright (c) 2015 Brnch. All rights reserved.
//

import UIKit

class AddContactTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var addCrewViewController : AddCrewViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


