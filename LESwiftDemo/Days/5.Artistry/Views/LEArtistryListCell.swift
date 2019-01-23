//
//  LEArtistryListCell.swift
//  LESwiftDemo
//
//  Created by LQQ on 2019/1/19.
//  Copyright © 2019 LQQ. All rights reserved.
//

import UIKit

class LEArtistryListCell: UITableViewCell {

    @IBOutlet weak var bioLB: UILabel!
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var artistImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
