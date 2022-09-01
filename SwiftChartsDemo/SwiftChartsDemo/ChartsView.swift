//
//  ChartsView.swift
//  SwiftChartsDemo
//
//  Created by Frank Chu on 8/25/22.
//

import SwiftUI
import Charts

struct Height: Identifiable {
    var id = UUID()
    let year: Int
    let Height: Int
    let num: Int
    
    static func generateData() -> [Self] {
        return [
            .init(year: 2001, Height: 100, num: 1),
            .init(year: 2002, Height: 130, num: 2),
            .init(year: 2003, Height: 135, num: 3),
            .init(year: 2004, Height: 140, num: 4),
            .init(year: 2005, Height: 143, num: 5),
            .init(year: 2006, Height: 145, num: 6),
            .init(year: 2007, Height: 149, num: 7)
            
        ]
    }
}
struct ChartsView: View, AXChartDescriptorRepresentable {
    func makeChartDescriptor() -> AXChartDescriptor {
        
        let xAxis = AXNumericDataAxisDescriptor(title: "数字", range: Double(0)...Double(10), gridlinePositions: []) {
            "\($0)"
        }
        
        let yAxis = AXNumericDataAxisDescriptor(title: "身高", range: Double(0)...Double(160), gridlinePositions: []) {
            "\($0)"
        }
        
        let series = AXDataSeriesDescriptor(
            name: "图",
            isContinuous: false,
            dataPoints: data.map{
                .init(x: Double($0.num), y: Double($0.Height))
            }
        )
        
        return AXChartDescriptor(title: "图", summary: nil, xAxis: xAxis, yAxis: yAxis, additionalAxes: [], series: [series])
    }
    
    
    
    let data = Height.generateData()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Chart(data) {
                    LineMark(x: .value("年份", $0.num), y: .value("身高", $0.Height))
                }
                .frame(height: 300)
                .accessibilityElement()
                .accessibilityChartDescriptor(self)
            }
        }
    }
}



struct ChartsView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
}
