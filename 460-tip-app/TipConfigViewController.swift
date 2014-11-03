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
    var model: TipDataObjectModel?
    
    @IBOutlet weak var minField: UITextField!
    @IBOutlet weak var maxField: UITextField!
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
    
    @IBAction func minEdited(sender: AnyObject)
    {
        self.model!.minTipPercent = NSString(format: "%@", self.minField.text).doubleValue / 100.0
    }
    
    @IBAction func maxEdited(sender: AnyObject)
    {
        self.model!.maxTipPercent = NSString(format: "%@", self.maxField.text).doubleValue / 100.0
    }
    
    @IBAction func tipOnTaxToggled(sender: AnyObject)
    {
        self.model!.tipOnTax = !self.model!.tipOnTax
    }
    
    @IBAction func tipOnDeductionsToggled(sender: AnyObject)
    {
        self.model!.tipOnDeductions = !self.model!.tipOnDeductions
    }
}
