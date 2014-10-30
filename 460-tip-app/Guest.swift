//
//  Guest.swift
//  460-tip-app
//
//  Created by David Ganey on 10/29/14.
//  Copyright (c) 2014 dhganey. All rights reserved.
//

import UIKit

class Guest: NSObject
{
    /// String representing the guest name
    var name : String = "Guest"
    
    /// Double representing the slider amount for the guest
    var tipPercent : Double = 0.0
    
    /// Double representing the actual tip amount for the guest (starts at 0)
    var tipAmount : Double = 0.0
}
