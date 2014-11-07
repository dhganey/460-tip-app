//
//  BillTotalTableViewCell.swift
//  460-tip-app
//
//  Created by David Ganey on 11/6/14.
//  Copyright (c) 2014 dhganey. All rights reserved.
//

import UIKit

class BillTotalTableViewCell: UITableViewCell
{
    var tableViewController: TipTailoringTableViewController?
    
    @IBOutlet weak var billLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
