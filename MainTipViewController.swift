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
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.setUpToolbar()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
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
    
    @IBAction func serviceSliderChanged(sender: UISlider)
    {
        self.model.serviceQuality = Double(self.serviceSlider.value)
        self.updateUI(self.model.modelUpdate())
    }
    
    @IBAction func numGuestsEdited(sender: AnyObject)
    {
        self.model.numGuests = self.numGuestsField.text.toInt()!
        self.updateUI(self.model.modelUpdate())
    }
    
    @IBAction func billTotalFieldChanged(sender: AnyObject)
    {
        let tempStr = NSString(string: self.billTotalField.text)
        self.model.billTotal = tempStr.doubleValue
        self.updateUI(self.model.modelUpdate())
    }
    
    @IBAction func billDeductionsFieldChanged(sender: AnyObject)
    {
        let tempStr = NSString(string: self.billDeductionsField.text)
        self.model.billDeductions = tempStr.doubleValue
        self.updateUI(self.model.modelUpdate())
    }
    
    @IBAction func taxRateFieldChanged(sender: AnyObject)
    {
        let tempStr = NSString(string: self.taxRateField.text)
        self.model.taxRate = tempStr.doubleValue
        self.updateUI(self.model.modelUpdate())
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
        self.performSegueWithIdentifier("tipTailorSegue", sender: self)
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
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        //var navController = segue.destinationViewController as UINavigationController //first, get the nav controller
        //var nextVC = navController.viewControllers[0] //then, get the first VC from that
        var nextVC = segue.destinationViewController
        if nextVC is TipTailorViewController
        {
            let myVC = segue.destinationViewController as TipTailorViewController
            myVC.model = self.model
        }
        else
        {
            let myVC = segue.destinationViewController as TipConfigViewController
            myVC.model = self.model
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
