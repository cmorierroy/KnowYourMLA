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
    
    class func colorOfParty(party: String) -> UIColor
    {
        var partyColor:UIColor = .black
        
        if(party == "PC")
        {
            partyColor = .blue
        }
        else if(party == "NDP")
        {
            partyColor = .orange
        }
        else if(party == "IND LIB")
        {
            partyColor = .red
        }
        
        return partyColor
    }
}
