//
//  photoCell.swift
//  Tumblr
//
//  Created by Jose Patino on 1/29/20.
//  Copyright © 2020 Jose Patino. All rights reserved.
//

import UIKit

class photoCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
