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
        self.tableViewController!.model!.isTailored = true

        let slider = sender as UISlider
        let indexPath = self.tableViewController!.tableView!.indexPathForCell(self)
        let sliderVal: Double = NSString(format: "%f", self.tipSlider.value).doubleValue
        let sliderMax: Double = NSString(format: "%f", self.tipSlider.maximumValue).doubleValue
        let sliderMin: Double = NSString(format: "%f", self.tipSlider.minimumValue).doubleValue
        
        let sliderPercent: Double = sliderVal / (sliderMax - sliderMin)
        
        //update the guest
        self.tableViewController!.model!.guestArray[indexPath!.row as Int].tipAmount = NSString(format: "%f", self.tipSlider.value).doubleValue
        
        //update the cells
        for (index, guest) in enumerate(self.tableViewController!.model!.guestArray)
        {
            let curCell = self.tableViewController!.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as GuestTableViewCell
            curCell.tipLabel.text = NSString(format: "%.2f", guest.tipAmount)
        }
        
        //update the model
        self.tableViewController!.model!.calculateTotalTip()
    }
    
    @IBAction func nameFieldChanged(sender: UITextField!)
    {
        let textField = sender as UITextField
        let indexPath = self.tableViewController!.tableView!.indexPathForCell(self)
        
        //update the guest
        self.tableViewController!.model!.guestArray[indexPath!.row as Int].name = nameField.text
    }
}
