//
//  MainTipViewController.swift
//  460-tip-app
//
//  Created by David Ganey on 10/27/14.
//  Copyright (c) 2014 dhganey. All rights reserved.
//

import UIKit

class MainTipViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var numGuestsField: UITextField!
    @IBOutlet weak var serviceSlider: UISlider!
    @IBOutlet weak var billTotalField: UITextField!
    @IBOutlet weak var billDeductionsField: UITextField!
    @IBOutlet weak var taxRateField: UITextField!
    @IBOutlet weak var tipRateLabel: UILabel!
    @IBOutlet weak var totalTipLabel: UILabel!
    @IBOutlet weak var perPersonTipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    var model: TipDataObjectModel = TipDataObjectModel()
    
    /// Initialize
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    /// Before the view appears, create the toolbar at the bottom
    override func viewWillAppear(animated: Bool)
    {
        self.setUpToolbar()
        self.updateUI(self.model.modelUpdate())
    }
    
    /// When we receive memory warnings, destroy things!
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    /// When the view loads, prepare the UI elements using the model defaults
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //set up the slider
        self.serviceSlider.maximumValue = 4.0
        self.serviceSlider.minimumValue = 0.0
        self.serviceSlider.value = 2.0
        
        //set up the fields
        self.numGuestsField.delegate = self
        self.numGuestsField.text = String(format: "%d", self.model.guestArray.count)
        
        self.taxRateField.text = String(format: "%.2f", self.model.taxRate) //TODO rounding
        
        self.billDeductionsField.text = String(format: "%.0f", self.model.billDeductions)
        
        self.totalLabel.text = String(format: "%.2f", self.model.billAndTipTotal)
        
        self.totalTipLabel.text = String(format: "%.2f", self.model.totalTip)
        
        self.billTotalField.text = String(format: "%.2f", self.model.billTotal)
    }
    
    /// Update the model with the new service slider.
    /// No error case
    @IBAction func serviceSliderChanged(sender: UISlider)
    {
        self.model.serviceQuality = Double(self.serviceSlider.value)
        self.updateUI(self.model.modelUpdate())
    }
    
    /// Update the model with new guests edited
    /// Error case: guests cannot be <= 0 or >  99
    @IBAction func numGuestsEdited(sender: AnyObject)
    {
        //verify:
        if (self.numGuestsField.text.toInt() <= 0 ||
            self.numGuestsField.text.toInt() > 99)
        {
            let alertController = UIAlertController(title: "Error", message: "Number of guests must be between 0 and 99", preferredStyle: UIAlertControllerStyle.Alert)
            let OKaction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                (action) in alertController.dismissViewControllerAnimated(true, completion: nil) //use lambda for action
            })
            alertController.addAction(OKaction)
            
            self.presentViewController(alertController, animated: true, completion: nil) //now alerts are ViewControllers!
            
            self.numGuestsField.text = self.model.getNumGuests() //reset to model
        }
        else //if clear to proceed, update and recalculate
        {
            self.model.numGuests = self.numGuestsField.text.toInt()!
            self.updateUI(self.model.modelUpdate())
        }
    }
    
    /// Update the model with new bill total
    /// Error case: bill cannot be negative, and bill cannot be less than deductions
    @IBAction func billTotalFieldChanged(sender: AnyObject)
    {
        let tempStr = NSString(string: self.billTotalField.text)
        let billTotalDouble = tempStr.doubleValue
        if (billTotalDouble < 0)
        {
            let alertController = UIAlertController(title: "Error", message: "Bill cannot be less than $0", preferredStyle: UIAlertControllerStyle.Alert)
            let OKaction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                (action) in alertController.dismissViewControllerAnimated(true, completion: nil)
            })
            alertController.addAction(OKaction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            self.billTotalField.text = self.model.getBillTotal() //reset to model
        }
        else if (billTotalDouble < (NSString(string: self.billDeductionsField.text).doubleValue))
        {
            let alertController = UIAlertController(title: "Error", message: "Bill cannot be less than deductions", preferredStyle: UIAlertControllerStyle.Alert)
            let OKaction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                (action) in alertController.dismissViewControllerAnimated(true, completion: nil)
            })
            alertController.addAction(OKaction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            self.billTotalField.text = self.model.getBillTotal() //reset to model
        }
        else //if clear to proceed, update and recalculate
        {
            self.model.billTotal = billTotalDouble
            self.updateUI(self.model.modelUpdate())
        }
    }
    
    /// Update the model with the new deductions amount
    /// Error case: deductions cannot be negative, nor greater than bill
    @IBAction func billDeductionsFieldChanged(sender: AnyObject)
    {
        let tempStr = NSString(string: self.billDeductionsField.text)
        let deductionsTotal = tempStr.doubleValue
        if (deductionsTotal < 0)
        {
            let alertController = UIAlertController(title: "Error", message: "Deductions cannot be less than 0", preferredStyle: UIAlertControllerStyle.Alert)
            let OKaction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                (action) in alertController.dismissViewControllerAnimated(true, completion: nil)
            })
            alertController.addAction(OKaction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            self.billDeductionsField.text = self.model.getBillDeductions() //reset to model
        }
        else if (deductionsTotal > (NSString(string: self.billTotalField.text).doubleValue))
        {
            let alertController = UIAlertController(title: "Error", message: "Deductions cannot be greater than bill amount", preferredStyle: UIAlertControllerStyle.Alert)
            let OKaction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                (action) in alertController.dismissViewControllerAnimated(true, completion: nil)
            })
            alertController.addAction(OKaction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            self.billDeductionsField.text = self.model.getBillDeductions() //reset to model
        }
        else //if clear to proceed, update and recalculate
        {
            self.model.billDeductions = deductionsTotal
            self.updateUI(self.model.modelUpdate())
        }
    }
    
    /// Updates the model with the new tax rate
    /// Error case: tax rate cannot be negative
    @IBAction func taxRateFieldChanged(sender: AnyObject)
    {
        let tempStr = NSString(string: self.taxRateField.text)
        let taxDouble = tempStr.doubleValue
        if (taxDouble < 0)
        {
            let alertController = UIAlertController(title: "Error", message: "Tax rate cannot be negative", preferredStyle: UIAlertControllerStyle.Alert)
            let OKaction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                (action) in alertController.dismissViewControllerAnimated(true, completion: nil)
            })
            alertController.addAction(OKaction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            self.taxRateField.text = self.model.getTaxRate() //reset to model
        }
        else //if clear to proceed, update and recalculate
        {
            self.model.taxRate = taxDouble
            self.updateUI(self.model.modelUpdate())
        }
    }

    func setUpToolbar()
    {
        let button1 = UIBarButtonItem(title: "Tip Tailoring", style: UIBarButtonItemStyle.Plain, target: self, action: "tipTailoringPressed")
        button1.width = (self.toolbar.frame.width) / 2
        let button2 = UIBarButtonItem(title: "Configuration", style: UIBarButtonItemStyle.Plain, target: self, action: "tipConfigPressed")
        button2.width = (self.toolbar.frame.width) / 2
        let buttons = [button1, button2]
        
        self.toolbar.setItems(buttons, animated: true)
    }
    
    func tipTailoringPressed()
    {
        if (self.numGuestsField.text.toInt() <= 1) //cannot tailor if only one guest!
        {
            let alertController = UIAlertController(title: "Error", message: "You cannot tailor a tip with only one guest", preferredStyle: UIAlertControllerStyle.Alert)
            let OKaction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                (action) in alertController.dismissViewControllerAnimated(true, completion: nil)
            })
            alertController.addAction(OKaction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else
        {
            self.performSegueWithIdentifier("tipTailorSegue", sender: self)
        }
    }
    
    func tipConfigPressed()
    {
        self.performSegueWithIdentifier("tipConfigSegue", sender: self)
    }
    
    func updateUI(param: (String, String, String, String))
    {
        self.tipRateLabel.text = param.0
        self.totalTipLabel.text = param.1
        self.perPersonTipLabel.text = param.2
        self.totalLabel.text = param.3
        println("UI updated")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "tipTailorSegue")
        {
            let navController = segue.destinationViewController as UINavigationController
            let nextVC = navController.topViewController as TipTailoringTableViewController
            nextVC.model = self.model
        }
        else if (segue.identifier == "tipConfigSegue")
        {
            let navController = segue.destinationViewController as UINavigationController
            let nextVC = navController.topViewController as TipConfigViewController
            nextVC.model = self.model
        }
        else
        {
            println("none of the segues work")
        }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        self.view.endEditing(true)
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        self.view.endEditing(true)
        self.view.resignFirstResponder()
    }
}
