//
//  PieChartView.swift
//  Read_bills
//
//  Created by chang xing on 10/08/2022.
//

import Foundation

import UIKit
import Charts

class PieChartViewController: UIViewController{
    //饼状图
    var chartView: PieChartView!
     
    override func viewDidLoad() {
        super.viewDidLoad()
         
        //创建饼图组件对象
        chartView = PieChartView()
        chartView.frame = CGRect(x: 20, y: 80, width: self.view.bounds.width - 40,
                                 height: 260)
        self.view.addSubview(chartView)
         
        //生成5条随机数据
        let dataEntries = (0..<5).map { (i) -> PieChartDataEntry in
            return PieChartDataEntry(value: Double(arc4random_uniform(50) + 10),
                                     label: "数据\(i)")
        }
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: "数据分布")
        //设置颜色
        chartDataSet.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
         
        chartDataSet.xValuePosition = .insideSlice //标签显示在内
        chartDataSet.yValuePosition = .outsideSlice //数值显示在外
         
        let chartData = PieChartData(dataSet: chartDataSet)
        chartData.setValueTextColor(.black)//文字颜色为黑色
         
        //设置饼状图数据
        chartView.data = chartData
        
    }
}
