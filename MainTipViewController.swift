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
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //set up the slider
        self.serviceSlider.maximumValue = 5.0
        self.serviceSlider.minimumValue = 0.0
        
        //set up the field
        self.numGuestsField.delegate = self
        self.numGuestsField.text = "0"
    }
    
    @IBAction func serviceSliderChanged(sender: UISlider)
    {
        self.model.serviceQuality = Double(self.serviceSlider.value)
        self.updateTotals()
    }
    
    @IBAction func numGuestsEdited(sender: AnyObject)
    {
        self.model.numGuests = self.numGuestsField.text.toInt()!
        println("num guests edited, model total is \(self.model.numGuests)")
        self.updateTotals()
    }
    
    @IBAction func billTotalFieldChanged(sender: AnyObject)
    {
        self.updateTotals()
    }
    @IBAction func billDeductionsFieldChanged(sender: AnyObject)
    {
        self.updateTotals()
    }
    @IBAction func taxRateFieldChanged(sender: AnyObject)
    {
        self.updateTotals()
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
    
    func updateTotals()
    {
        
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
}
