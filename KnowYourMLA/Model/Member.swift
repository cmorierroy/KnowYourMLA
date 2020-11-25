//
//  Member.swift
//  KnowYourMLA
//
//  Created by Cédric Morier-Roy on 2020-11-25.
//

import Foundation

class Member
{
    let firstName:String
    let lastName:String
    let constituency:String
    let party:String
    let isMinister:Bool
    
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
    }
    
    func toString() -> String
    {
        return "Name: \(name)\nConstituency: \(constituency)\nParty: \(party)"
    }
}
