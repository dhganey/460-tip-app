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
        let slider = sender as UISlider
        let indexPath = tableView!.indexPathForCell(self)
        
        let sliderVal: Double = NSString(format: "%f", self.tipSlider.value).doubleValue
        let sliderMax: Double = NSString(format: "%f", self.tipSlider.maximumValue).doubleValue
        let sliderMin: Double = NSString(format: "%f", self.tipSlider.minimumValue).doubleValue
        
        let sliderPercent: Double = sliderVal / (sliderMax - sliderMin)
        
        //update the guest
        tableViewController!.model!.guestArray[indexPath!.row as Int].tipPercent = sliderPercent
        
        //update the other guests
        let sliderChange: Double = sliderPercent / Double(self.tableViewController!.model!.numGuests)
        
        for (index, guest) in enumerate(tableViewController!.model!.guestArray)
        {
            if (index != indexPath!.row as Int) //don't modify the current guest!
            {
                let newPath = NSIndexPath(forRow: index, inSection: 1)
                let curCell = tableView!.cellForRowAtIndexPath(newPath) as GuestTableViewCell
                curCell.tipSlider.value -= NSString(format: "%f", sliderChange).floatValue
                guest.tipPercent -= sliderChange //TODO one of these must be incorrect
            }
        }
    }
    
    @IBAction func nameFieldChanged(sender: UITextField!)
    {
        let textField = sender as UITextField
        let indexPath = tableView!.indexPathForCell(self)
        
        //update the guest
        tableViewController!.model!.guestArray[indexPath!.row as Int].name = nameField.text
    }
}
