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
        let indexPath = self.tableViewController!.tableView!.indexPathForCell(self)
        let sliderVal: Double = NSString(format: "%f", self.tipSlider.value).doubleValue
        let sliderMax: Double = NSString(format: "%f", self.tipSlider.maximumValue).doubleValue
        let sliderMin: Double = NSString(format: "%f", self.tipSlider.minimumValue).doubleValue
        
        let sliderPercent: Double = sliderVal / (sliderMax - sliderMin)
        
        //update the guest
        let curGuest = tableViewController!.model!.guestArray[indexPath!.row as Int] as Guest
        let oldTipPercent = curGuest.tipPercent
        curGuest.tipPercent = sliderPercent //we can do this absolutely -- if the slider is at 35%, that's the tip percentage
        curGuest.tipAmount = curGuest.tipPercent * tableViewController!.model!.totalTip //TODO check this
        
        //now update the other guests
        let sliderChange = (oldTipPercent - sliderPercent) / (Double(tableViewController!.model!.numGuests) - 1) //subtract 1 to divide among REMAINING guests
        
        for (index, guest) in enumerate(tableViewController!.model!.guestArray)
        {
            if (index != indexPath!.row as Int) //don't modify the current guest!
            {
                let curCell = self.tableViewController!.tableView!.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as GuestTableViewCell
                curCell.tipSlider.value += NSString(format: "%f", sliderChange).floatValue
                guest.tipPercent += sliderChange //the guest tippercent is stored as a full percentage
                guest.tipAmount = guest.tipPercent * tableViewController!.model!.totalTip
            }
        }
        
        //update the cells
        for (index, guest) in enumerate(tableViewController!.model!.guestArray)
        {
            let curCell = self.tableViewController!.tableView!.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as GuestTableViewCell
            curCell.tipLabel.text = NSString(format: "%.0f%% -- %.2f", guest.tipPercent * 100.0, guest.tipAmount)
        }
        
        self.tableViewController!.model!.isTailored = true
    }
    
    @IBAction func nameFieldChanged(sender: UITextField!)
    {
        let textField = sender as UITextField
        let indexPath = self.tableViewController!.tableView!.indexPathForCell(self)
        
        //update the guest
        self.tableViewController!.model!.guestArray[indexPath!.row as Int].name = nameField.text
    }
}
