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
    
    /// Refers to calculated tip rate. Defaults to 20%
    var tipRate : Double = 0.20
    
    /// Refers to calculated tax amount
    var tax : Double = 0.0
    
    /// Refers to calculated total tip
    var totalTip : Double = 0.0
    
    /// Refers to calculated per-person tip. Always calculated, but only relevant/shown when not tailored
    var perpersonTip : Double = 0.0
    
    /// Refers to the calculated bill total with bill + tip
    var billAndTipTotal : Double = 0.0
    
    /// Recognizes when the tip has been tailored
    var isTailored : Bool = false
    
    /// Set by the config screen. By default, leaves the tax out of the tip equation
    var tipOnTax : Bool = false
    
    /// Set by the config screen. By default, includes deductions in the tip equation.
    /// In this case, tipping on deductions "true" means that you tip on the whole bill
    var tipOnDeductions : Bool = true
    
    /// Set by the config screen. By default, minimum tip for awful service is 0%
    var minTipPercent : Double = 0.0
    
    /// Set by the config screen. By default, max tip for great service is 40%
    var maxTipPercent : Double = 0.40
    
    /// Array containing Guests
    var guestArray : Array<Guest>
    
    /// Determines the tip rate by multiplying the quality of service by the tip range
    func calculateTipRate()
    {
        self.tipRate = (self.minTipPercent + (self.serviceQuality / 4.0) * (self.maxTipPercent - self.minTipPercent))
    }
    
    func calculateTotalTip()
    {
        var total = 0.0
        for guest in self.guestArray
        {
            total += guest.tipAmount
        }
        
        self.totalTip = total
    }
    
    func calculatePerPersonTip()
    {
        //if we're not tailoring the tip, each guest just pays their share equally divided
        var tip: Double
        if (!self.isTailored)
        {
            var amt: Double
            if (self.tipOnDeductions)
            {
                amt = self.billTotal
            }
            else
            {
                amt = self.billTotal - self.billDeductions
            }
            
            if (self.tipOnTax)
            {
                amt = amt + self.tax
            }
            //else don't consider the tax
            
            tip = (self.tipRate *  amt)
            
            for guest in self.guestArray
            {
                guest.tipPercent = (1.0 / Double(numGuests))
                guest.tipAmount = (tip / Double(numGuests))
            }
            
            self.perpersonTip = (tip / Double(numGuests))
        }
        else //if we are tailoring the tip, each guest should already be set. just add them up
        {
            tip = 0
            
            for guest in self.guestArray
            {
                //guest.tipPercent should already be set, don't change it! it's set by the tailoring screen
                tip += guest.tipAmount
            }
            
            self.perpersonTip = -1 //because we are tailoring
        }
    }
    
    func calculateTax()
    {
        self.tax = (self.taxRate * (self.billTotal - self.billDeductions))
    }
    
    func calculateTotal()
    {
        self.billAndTipTotal = (self.billTotal - self.billDeductions + self.totalTip + self.tax)
    }
    
    func updateGuests()
    {
        if (self.guestArray.count < numGuests) //we need to add guests
        {
            for i in self.guestArray.count..<numGuests //runs once for each new guest
            {
                let g = Guest()
                
                g.name = String(format: "Guest %d", self.guestArray.count + 1)
                if (!self.isTailored)
                {
                    g.tipPercent = (1.0 / Double(numGuests))
                }
                
                guestArray.append(g)
            }
        }
        else if (self.guestArray.count > numGuests)//we need to remove guests (just kill them from the end of the array for now)
        {
            for i in numGuests..<self.guestArray.count //runs once for each guest to be removed
            {
                self.guestArray.removeLast()
            }
            if (!self.isTailored) //restore the tip percentages
            {
                for g in guestArray
                {
                    g.tipPercent = (1.0 / Double(numGuests))
                }
            }
        }
        
        //if they're equal, we take no action
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
        self.updateGuests()
        self.calculateTax()
        self.calculateTipRate()
        self.calculatePerPersonTip()
        self.calculateTotalTip()
        self.calculateTotal()
        
        var tipRate: String
        var perpersonTip: String
        if (self.isTailored)
        {
            tipRate = "Tip Tailored"
            perpersonTip = "Tip Tailored"
        }
        else
        {
            tipRate = String(format: "%.2f", self.tipRate) //TODO round
            perpersonTip = String(format: "%.2f", self.perpersonTip)
        }
        
        let totalTip = String(format: "%.2f", self.totalTip)
        let billTotal = String(format: "%.2f", self.billAndTipTotal)
        
        return (tipRate, totalTip, perpersonTip, billTotal)
    }
    
    override init()
    {
        //most values have defaults but guest array does not
        guestArray = Array<Guest>() //init
        
        //create the default guest
        let myGuest = Guest()
        myGuest.name = "Guest 1"
        myGuest.tipPercent = 1.0
        
        guestArray.append(myGuest)
    }
    
    func getBillTotal() -> String
    {
        return String(format: "%.2f", self.billTotal) //TODO format with currency
    }
    
    func getNumGuests() -> String
    {
        return String(format: "%d", self.numGuests)
    }
    
    func getBillDeductions() -> String
    {
        return String(format: "%.2f", self.billDeductions) //TODO
    }
    
    func getTaxRate() -> String
    {
        return String(format: "%.2f", self.taxRate) //TODO
    }
}
