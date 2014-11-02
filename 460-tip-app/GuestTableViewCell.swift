//
//  GuestTableViewCell.swift
//  460-tip-app
//
//  Created by David Ganey on 11/2/14.
//  Copyright (c) 2014 dhganey. All rights reserved.
//

import UIKit

class GuestTableViewCell: UITableViewCell
{
    var tableView: UITableView?
    var tableViewController: TipTailoringTableViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBAction func sliderChanged(sender: AnyObject)
    {
        
    }
    
    @IBAction func nameFieldChanged(sender: UITextField!)
    {
        let textField = sender as UITextField
        let indexPath = tableView!.indexPathForCell(self)
        
        //update the guest
        tableViewController!.model!.guestArray[indexPath!.row as Int].name = nameField.text
    }
}
