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
