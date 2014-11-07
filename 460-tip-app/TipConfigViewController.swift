//
//  TipConfigViewController.swift
//  460-tip-app
//
//  Created by David Ganey on 10/29/14.
//  Copyright (c) 2014 dhganey. All rights reserved.
//

import UIKit

class TipConfigViewController: UIViewController
{
    var model: TipDataObjectModel? //weak reference to singleton model

    /// IBOutlets tied to storyboard UI fields
    @IBOutlet weak var maxField: UITextField!
    @IBOutlet weak var minField: UITextField!
    @IBOutlet weak var tipOnTaxSwitch: UISwitch!
    @IBOutlet weak var tipOnDeductionsSwitch: UISwitch!

    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        minField.text = NSString(format: "%.2f", self.model!.minTipPercent * 100.0)
        maxField.text = NSString(format: "%.2f", self.model!.maxTipPercent * 100.0)
        
        self.tipOnTaxSwitch.on = self.model!.tipOnTax
        self.tipOnDeductionsSwitch.on = self.model!.tipOnDeductions
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    /// When the min field is edited, checks for errors and updates model
    @IBAction func minEdited(sender: AnyObject)
    {
        let minStr: NSString = self.minField.text
        let newMin = minStr.doubleValue / 100.0
        
        if (newMin > self.model!.maxTipPercent) //min > max not allowed
        {
            let alertController = UIAlertController(title: "Error", message: "Min tip cannot be lower than max", preferredStyle: UIAlertControllerStyle.Alert)
            let OKaction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                (action) in alertController.dismissViewControllerAnimated(true, completion: nil)
            })
            alertController.addAction(OKaction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            //reset to model
            self.minField.text = NSString(format: "%.2f", (self.model!.minTipPercent * 100.0))
        }
        else if (newMin < 0) //min < 0 not allowed
        {
            let alertController = UIAlertController(title: "Error", message: "Min tip cannot be lower than 0", preferredStyle: UIAlertControllerStyle.Alert)
            let OKaction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                (action) in alertController.dismissViewControllerAnimated(true, completion: nil)
            })
            alertController.addAction(OKaction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            //reset to model
            self.minField.text = NSString(format: "%.2f", (self.model!.minTipPercent * 100.0))
        }
        else //good to go
        {
            self.model!.minTipPercent = newMin
            self.minField.text = NSString(format: "%.2f", (self.model!.minTipPercent * 100.0))
        }
    }
    
    /// When the max field is edited, checks for errors and updates the model
    @IBAction func maxEdited(sender: AnyObject)
    {
        let maxStr: NSString = self.maxField.text
        let newMax = maxStr.doubleValue / 100.0
        
        if (newMax < self.model!.minTipPercent) //max < min not allowed
        {
            let alertController = UIAlertController(title: "Error", message: "Max tip cannot be lower than min", preferredStyle: UIAlertControllerStyle.Alert)
            let OKaction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                (action) in alertController.dismissViewControllerAnimated(true, completion: nil)
            })
            alertController.addAction(OKaction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            //reset to model
            self.maxField.text = NSString(format: "%.2f", (self.model!.maxTipPercent * 100.0))
        }
        else if (newMax < 0) //max < 0 not allowed
        {
            let alertController = UIAlertController(title: "Error", message: "Max tip cannot be lower than 0", preferredStyle: UIAlertControllerStyle.Alert)
            let OKaction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                (action) in alertController.dismissViewControllerAnimated(true, completion: nil)
            })
            alertController.addAction(OKaction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            //reset to model
            self.maxField.text = NSString(format: "%.2f", (self.model!.maxTipPercent * 100.0))
        }
        else //good to go
        {
            self.model!.maxTipPercent = newMax
            self.maxField.text = NSString(format: "%.2f", (self.model!.maxTipPercent * 100.0))

        }

    }
    
    /// When the switch is toggled, toggle the model
    @IBAction func tipOnTaxToggled(sender: AnyObject)
    {
        self.model!.tipOnTax = !self.model!.tipOnTax
    }
    
    /// When the switch is toggled, toggle the model
    @IBAction func tipOnDeductionsToggled(sender: AnyObject)
    {
        self.model!.tipOnDeductions = !self.model!.tipOnDeductions
    }
}
