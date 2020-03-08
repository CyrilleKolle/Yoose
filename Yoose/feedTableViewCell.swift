//
//  feedTableViewCell.swift
//  Yoose
//
//  Created by Indigo´sDad on 2020-03-08.
//  Copyright © 2020 Indigo´sDad. All rights reserved.
//

import UIKit

class feedTableViewCell: UITableViewCell {

    @IBOutlet weak var postInCell: UILabel!
    @IBOutlet weak var ImageInFeedCell: UIImageView!
    @IBOutlet weak var countryInCell: UILabel!
    @IBOutlet weak var profileImageInCell: UIImageView!
    
    @IBOutlet weak var durationInCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
