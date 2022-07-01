//
//  TableViewCell.swift
//  MisFitApp_V1.2
//
//  Created by Shuvo on 6/30/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var tableViewCellButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
