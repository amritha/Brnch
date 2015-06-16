//
//  AddLocationTableViewCell.swift
//  Brnch
//
//  Created by Amritha Prasad on 6/14/15.
//  Copyright (c) 2015 Brnch. All rights reserved.
//

import UIKit

class AddLocationTableViewCell: UITableViewCell {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onAdded(sender: AnyObject) {
        
        if addButton.selected == false{
            addButton.selected = true}
        
        else if addButton.selected == true{
            addButton.selected = false
        }
        
    }
}
