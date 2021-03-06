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
    //MARK: Endpoints
    enum Endpoints
    {
        static let base = "https://www.gov.mb.ca/legislature"
        static let members = "/members"
        
        case getMembersListByConstituency
        case getMemberInfo(String)
        case getMemberPhoto(String)
        
        var stringValue: String
        {
            switch self
            {
            case .getMembersListByConstituency: return Endpoints.base + Endpoints.members + "/mla_list_constituency.html"
            case .getMemberInfo(let lastName): return Endpoints.base + Endpoints.members + "/info/\(replaceDiacritics(text: lastName)).html" //really janky way to avoid a bug, but this should be adjusted to replace any diacritic
            case .getMemberPhoto(let lastName): return "https://www.gov.mb.ca/legislature/img/mla/\(replaceDiacritics(text: lastName)).jpg"
            }
            
        }
        
        var url: URL
        {
            return URL(string: stringValue)!
        }
    }
    
    class func replaceDiacritics(text:String) -> String
    {
        //for lowercase letters only
        let alphabet = ["a","c","e","i","o","u"]
        
        let aDiacritics = ["à","á","â","ä"]
        let cDiacritics = ["ç"]
        let eDiacritics = ["è","é","ê","ë"]
        let iDiacritics = ["î","ï"]
        let oDiacritics = ["ô","ö"]
        let uDiacritics = ["û","ü"]
    
        var diacriticsList:[[String]] = []
        diacriticsList.append(aDiacritics)
        diacriticsList.append(cDiacritics)
        diacriticsList.append(eDiacritics)
        diacriticsList.append(iDiacritics)
        diacriticsList.append(oDiacritics)
        diacriticsList.append(uDiacritics)
        
        var newText = text
        for arrayIndex in 0..<diacriticsList.count
        {
            for diacritic in diacriticsList[arrayIndex]
            {
                newText = newText.replacingOccurrences(of: diacritic, with: alphabet[arrayIndex])
            }
        }
        
        return newText
    }
    
    class func scrapeMembersList(completion: @escaping () -> Void)
    {
        AF.request(Endpoints.getMembersListByConstituency.url).response
        {
            response in
            if let data = response.data
            {
                let dataString = String(decoding: data, as: UTF8.self )
                self.parseMemberList(html: dataString)
                completion()
            }
        }
    }
    
    class func scrapePhotos(completion: @escaping () -> Void)
    {
        var url:URL
        for i in 0..<MLAData.members.count
        {
            url = Endpoints.getMemberPhoto(MLAData.members[i].lastName.lowercased()).url
            AF.request(url).response
            {
                response in
                if let data = response.data
                {
                    MLAData.members[i].image =  UIImage(data: data) ?? UIImage()
//                    let dataString = String(decoding: data, as: UTF8.self )
//                    self.parseMemberPhoto(html: dataString)
                    completion()
                }
            }

//            let data = try? Data(contentsOf: url)
//            MLAData.members[i].image =  UIImage(data: data!) ?? UIImage()
        }
        
//        print(url)
    }
    
    //MARK: PARSING FUNCTIONS
    class func parseMemberList(html: String)
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
                //print(member.toString() + "\n")
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
    
    class func parseMemberPhoto(html:String)
    {
        let doc = try? Kanna.HTML(html: html, encoding: String.Encoding.utf8)
        
        if let doc = doc
        {
            //get all <table> elements
            let pictureElement = doc.css("img")
            
            print(pictureElement[6].toHTML)
            
            //parse members table
            //let membersCells = tables[0].css("td")
            
        }
    }
}
