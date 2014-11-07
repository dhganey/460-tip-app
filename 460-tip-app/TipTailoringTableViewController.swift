//
//  TipTailoringTableViewController.swift
//  460-tip-app
//
//  Created by David Ganey on 11/2/14.
//  Copyright (c) 2014 dhganey. All rights reserved.
//

import UIKit

class TipTailoringTableViewController: UITableViewController, UITableViewDataSource
{
    var model : TipDataObjectModel? //weak reference to singleton model
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.model!.numGuests
    }

    /// Creates a cell using the model
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("myGuestCell", forIndexPath: indexPath) as GuestTableViewCell

        cell.tableViewController = self //maintain weak reference here
        
        cell.nameField!.text = self.model!.guestArray[indexPath.row as Int].name
        cell.tipSlider.maximumValue = NSString(format: "%f", self.model!.maxTipPercent * self.model!.billTotal).floatValue //TODO adjust for tippable amount
        cell.tipSlider.minimumValue = NSString(format: "%f", self.model!.minTipPercent * self.model!.billTotal).floatValue //this too
        let amount = self.model!.guestArray[indexPath.row as Int].tipAmount
        cell.tipSlider.value = NSString(format: "%f", amount).floatValue
        cell.tipLabel.text = NSString(format: "%.2f", amount) //TODO rounding
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation
}
