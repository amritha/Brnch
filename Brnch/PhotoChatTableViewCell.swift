//
//  PhotoChatTableViewCell.swift
//  Brnch
//
//  Created by Amritha Prasad on 6/24/15.
//  Copyright (c) 2015 Brnch. All rights reserved.
//

import UIKit

class PhotoChatTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
