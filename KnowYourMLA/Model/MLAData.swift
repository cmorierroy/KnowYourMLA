//
//  MLAData.swift
//  KnowYourMLA
//
//  Created by Cédric Morier-Roy on 2020-11-25.
//

import Foundation
import UIKit

class MLAData
{
    static var partyCounts = [Double]()
    static var parties = [String]()
    static var members = [Member]()
    static var totalSeats = 0
    
    class func colorOfParty(party: String) -> CGColor
    {
        var partyColor:CGColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        
        if(party == "PC")
        {
            partyColor = CGColor(red: 0, green: 0, blue: 1.0, alpha: 1.0)
        }
        else if(party == "NDP")
        {
            partyColor = CGColor(red: 1.0, green: 0.65, blue: 0, alpha: 1.0)
        }
        else if(party == "IND LIB")
        {
            partyColor = CGColor(red: 1.0, green: 0, blue: 0, alpha: 1.0)
        }
        
        return partyColor
    }
}
