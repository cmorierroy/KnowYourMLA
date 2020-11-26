//
//  Member.swift
//  KnowYourMLA
//
//  Created by Cédric Morier-Roy on 2020-11-25.
//

import Foundation
import UIKit
class Member : CustomStringConvertible
{
    let firstName:String
    let lastName:String
    var constituency:String
    var party:String
    var isMinister:Bool
    var image:UIImage
    
    var name:String
    {
        firstName + " " + lastName + (isMinister ? " (M)" : "")
    }
    
    init(firstName:String,lastName:String, constituency: String,party:String, isMinister:Bool = false)
    {
        self.firstName = firstName
        self.lastName = lastName
        self.constituency = constituency
        self.party = party
        self.isMinister = isMinister
        image = UIImage()
    }
    
    var description: String
    {
        return "Name: \(name)\nConstituency: \(constituency)\nParty: \(party)"
    }
}
