//
//  SearchTableViewCell.swift
//  JournalApp
//
//  Created by Shena Yoshida on 9/5/16.
//  Copyright © 2016 Shena Yoshida. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var labelDetail: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageContentView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
