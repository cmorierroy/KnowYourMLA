//
//  HomeVC.swift
//  KnowYourMLA
//
//  Created by Cédric Morier-Roy on 2020-11-24.
//

import UIKit
import Charts

class HomeVC: UIViewController
{
    @IBOutlet weak var pieChart: PieChartView!
    
    //mock data
    var parties = [String]()
    var members = [Int]()
    
    //MARK: Lifecycle Functions
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //scrape web data
        MLAScraper.scrape()
        {
            //add scraped data to chart
            self.customizeChart(dataPoints:MLAData.parties, values: MLAData.partyCounts)
            self.pieChart.animate(xAxisDuration: 1, yAxisDuration: 1)
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        pieChart.animate(xAxisDuration: 1, yAxisDuration: 1)
    }
    
    private func customizeChart(dataPoints: [String], values: [Double])
    {
        //Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count
        {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        //Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = [UIColor.blue,UIColor.orange,UIColor.red]
        
        //Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        //Assign it to the chart’s data
        pieChart.data = pieChartData
        
        //customize legend
        pieChart.legend.textColor = .white
        //LegendEntry(label: <#T##String?#>, form: <#T##Legend.Form#>, formSize: <#T##CGFloat#>, formLineWidth: <#T##CGFloat#>, formLineDashPhase: <#T##CGFloat#>, formLineDashLengths: <#T##[CGFloat]?#>, formColor: <#T##NSUIColor?#>)
        //pieChart.legend.setCustom(entries: parties)
        
        //customize center text
        pieChart.centerText = "Total Seats:\(MLAData.totalSeats)"
        
        //TODO: change look of chart middle
        //TODO: change labels on chart to be acronym of parties, place full names in legend
    }
}

