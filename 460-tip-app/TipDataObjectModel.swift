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
    
    /// Set by the config screen. By default, leaves the tax out of the tip equation
    var tipOnTax : Bool = false
    
    /// Set by the config screen. By default, includes deductions in the tip equation.
    /// In this case, tipping on deductions "true" means that you tip on the whole bill
    var tipOnDeductions : Bool = true
    
    /// Set by the config screen. By default, minimum tip for awful service is 0%
    var minTipPercent : Double = 0.0
    
    /// Set by the config screen. By default, max tip for great service is 40$
    var maxTipPercent : Double = 40.0
    
    func calculateTipRate() -> Double
    {
        //TODO
        return 10.0
    }
    
    func calculateTotalTip() -> Double
    {
        //TODO
        return 10.0
    }
    
    func calculatePerPersonTip() -> Double
    {
        //TODO
        return 10.0
    }
    
    func calculateTotal() -> Double
    {
        //TODO
        return 10.0
    }
}
