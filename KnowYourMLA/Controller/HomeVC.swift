//
//  HomeVC.swift
//  KnowYourMLA
//
//  Created by Cédric Morier-Roy on 2020-11-24.
//

import UIKit
import Charts
import Alamofire
import Kanna

class HomeVC: UIViewController
{
    @IBOutlet weak var pieChart: PieChartView!
    
    //mock data
    var parties = [String]()
    var members = [Int]()
    var totalSeats = 0
    
    //Endpoint
    let partyStatsEndpoint = "https://www.gov.mb.ca/legislature/members/mla_list_constituency.html"
    
    //MARK: Lifecycle Functions
    override func viewDidLoad()
    {
        super.viewDidLoad()
        scrape()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    func customizeChart(dataPoints: [String], values: [Double])
    {
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count
        {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors =  [UIColor.blue,UIColor.orange,UIColor.red]//colorsOfCharts(numbersOfColor: dataPoints.count)
        
         // 3. Set ChartData
         let pieChartData = PieChartData(dataSet: pieChartDataSet)
         let format = NumberFormatter()
         format.numberStyle = .none
         let formatter = DefaultValueFormatter(formatter: format)
         pieChartData.setValueFormatter(formatter)
        
         // 4. Assign it to the chart’s data
         pieChart.data = pieChartData
        pieChart.legend.textColor = .white
//        LegendEntry(label: <#T##String?#>, form: <#T##Legend.Form#>, formSize: <#T##CGFloat#>, formLineWidth: <#T##CGFloat#>, formLineDashPhase: <#T##CGFloat#>, formLineDashLengths: <#T##[CGFloat]?#>, formColor: <#T##NSUIColor?#>)
        //pieChart.legend.setCustom(entries: parties)
        pieChart.animate(xAxisDuration: 1, yAxisDuration: 1)
        pieChart.centerText = "Total Seats:\(totalSeats)"
        //pieChart.backgroundColor = .black
        
    }
    
    //Generates random array of colours
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor]
    {
        var colors: [UIColor] = []
        
        for _ in 0..<numbersOfColor
        {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        return colors
    }
    
    func scrape() -> Void
    {
        AF.request(partyStatsEndpoint).response
        {
            response in
            if let data = response.data
            {
                let dataString = String(decoding: data, as: UTF8.self )
                self.parseHTML(html: dataString)
            }
        }
    }

    func parseHTML(html: String)
    {
        let doc = try? Kanna.HTML(html: html, encoding: String.Encoding.utf8)

        if let doc = doc
        {
            let tables = doc.css("table")
            let totalsTable = tables[1]
            
            var isLabel = true
            
            for cell in totalsTable.css("td")
            {
                //alternate between storing label and value for label
                if(isLabel)
                {
                    isLabel = false
                    parties.append(cell.text ?? "")
                }
                else
                {
                    isLabel = true
                    members.append(Int(cell.text ?? "0") ?? 0)
                }
            }
            
            //Remove last element in each array, since we know it's the total:
            parties.removeLast()
            members.removeLast()
            
            for total in members
            {
                totalSeats += total
            }
            
            //add scraped data to chart
            customizeChart(dataPoints:parties, values: members.map{Double($0)})
        }
    }
}

