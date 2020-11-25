//
//  MLAScraper.swift
//  KnowYourMLA
//
//  Created by Cédric Morier-Roy on 2020-11-25.
//

import Foundation
import Alamofire
import Kanna

class MLAScraper
{
    //Endpoint
    static let MembersEndpoint = "https://www.gov.mb.ca/legislature/members/mla_list_constituency.html"
    
    class func scrape(completion: @escaping () -> Void)
    {
        AF.request(MembersEndpoint).response
        {
            response in
            if let data = response.data
            {
                let dataString = String(decoding: data, as: UTF8.self )
                self.parseHTML(html: dataString)
                completion()
            }
        }
        
    }
    
    class func parseHTML(html: String)
    {
        let doc = try? Kanna.HTML(html: html, encoding: String.Encoding.utf8)
        
        if let doc = doc
        {
            //get all <table> elements
            let tables = doc.css("table")
            
            //parse members table
            let membersCells = tables[0].css("td")
            for index in stride(from: 0, to: membersCells.count, by: 3)
            {
                //get constituency from cell
                let constituency = membersCells[index].text ?? ""
                
                //get names from cell
                let separatedNames = (membersCells[index+1].text ?? "").split(separator: ",")
                
                //process last name
                let lastName = String(separatedNames[0]).lowercased().capitalized.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                //process first name
                let separatedFirstName = separatedNames[1].split(separator: ".")
                var firstName:String
                var isMinister:Bool = false
                
                if separatedFirstName.count > 1
                {
                    //if the member is a minister (has 'Hon.' in name)
                    firstName = separatedFirstName[1].trimmingCharacters(in:CharacterSet.whitespacesAndNewlines)
                    isMinister = true
                }
                else
                {
                    firstName = separatedFirstName[0].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                }
                
                //get party from cell
                let party = membersCells[index+2].text ?? ""
                
                //append member
                let member = Member(firstName: firstName, lastName: lastName, constituency: constituency, party: party, isMinister:isMinister)
                print(member.toString() + "\n")
                MLAData.members.append(member)
                
            }
            
            //parse totals table
            let totalsTable = tables[1]
            var isLabel = true
            
            for cell in totalsTable.css("td")
            {
                //alternate between storing label and value for label
                if(isLabel)
                {
                    isLabel = false
                    MLAData.parties.append(cell.text ?? "")
                }
                else
                {
                    isLabel = true
                    MLAData.partyCounts.append(Double(cell.text ?? "0") ?? 0.0)
                }
            }
            
            //Remove last element in each array, since we know it's the total:
            MLAData.parties.removeLast()
            MLAData.partyCounts.removeLast()
            
            for total in MLAData.partyCounts
            {
                MLAData.totalSeats += Int(total)
            }
        }
    }
}
