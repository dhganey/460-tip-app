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

    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        minField.text = NSString(format: "%.2f", self.model!.minTipPercent * 100.0)
        maxField.text = NSString(format: "%.2f", self.model!.maxTipPercent * 100.0)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func minEdited(sender: AnyObject)
    {
        
    }
    
    @IBAction func maxEdited(sender: AnyObject)
    {
        
    }
}
