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
    var numGuests : Int = 1
    
    /// The service quality is a scale from 0 to 4, defaulting to 2
    var serviceQuality : Double = 2.0
    
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
    
    /// Array containing Guests
    var guestArray : Array<Guest>
    
    /// Determines the tip rate by multiplying the quality of service by the tip range
    func calculateTipRate() -> Double
    {
        let temp = (minTipPercent + ((self.serviceQuality / 4.0) * (maxTipPercent - minTipPercent)))
        println(temp)

        return (
            minTipPercent + ((self.serviceQuality / 4.0) * (maxTipPercent - minTipPercent))
        )
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
    
    /**
    This function drives all updates for the application
    This allows the viewcontroller to forget about logic
    The view controller simply updates all UI elements with the result of this function
    
    The strings in order are:
    tip rate, total tip, per person tip, total bill 
    */
    func modelUpdate() -> (String, String, String, String)
    {
        let tipRate = String(format: "%.2f", calculateTipRate()) //TODO round these as currency, not with truncation
        let totalTip = String(format: "%.2f", calculateTotalTip())
        let perpersonTip = String(format: "%.2f", calculatePerPersonTip())
        let total = String(format: "%.2f", calculateTotal())
        
        return (tipRate, totalTip, perpersonTip, total)
    }
    
    override init()
    {
        //most values have defaults but guest array does not
        guestArray = Array<Guest>() //init
        
        //create the default guest
        let myGuest = Guest()
        myGuest.name = "Guest 1"
        myGuest.tipPercent = 100
        
        guestArray.append(myGuest)
    }
}
