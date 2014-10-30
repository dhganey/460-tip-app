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
        
        //set up the field
        self.numGuestsField.delegate = self
        self.numGuestsField.text = "0"
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
        self.model.billTotal = tempStr.doubleValue
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
        println("tailoring pressed")
    }
    
    func tipConfigPressed()
    {
        println("config pressed")
    }
    
    func updateUI(param: (String, String, String, String))
    {
        self.tipRateLabel.text = param.0
        self.totalTipLabel.text = param.1
        self.perPersonTipLabel.text = param.2
        self.totalTipLabel.text = param.3
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        //TODO
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
