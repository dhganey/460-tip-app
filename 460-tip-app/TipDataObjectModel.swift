//
//  TipDataObjectModel.swift
//  460-tip-app
//
//  Created by David Ganey on 10/28/14.
//  Copyright (c) 2014 dhganey. All rights reserved.
//

import UIKit


class TipDataObjectModel: NSObject
{
    /// The number of guests defaults to 1
    var numGuests : Int8 = 1
    
    /// The service quality is a scale from 1 to 5, defaulting to 3
    var serviceQuality : Double = 3.0
    
    /// The bill total starts at 0
    var billTotal : Double = 0.0
    
    /// Deductions default to 0
    var billDeductions : Double = 0.0
    
    /// Tax rate defaults to 10%
    var taxRate : Double = 0.10
    
    /// Refers to calculated tax amount
    var tax : Double = 0.0
    
    /// Recognizes when the tip has been tailored
    var isTailored : Bool = false
}
