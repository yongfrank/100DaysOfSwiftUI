//
//  ChartsView.swift
//  SwiftChartsDemo
//
//  Created by Frank Chu on 8/25/22.
//

import SwiftUI
import Charts

//class DataOfChartsViewModel {
//    @Published data: [DataOfCharts]
//
//    init() {
//        self.data = generateData()
//    }
//
//    func generateData() -> [Self] {
//        return [
//
//        ]
//    }
//}

struct DataOfCharts: Identifiable {
    let id = UUID()
    let coopration: Int
    let date: Date
    var animate = false
    let coopration2: Int
    let date2: Date
//    var animate = false
}


struct ContentView: View {
    var datelength: [DateLength] = [.seven, .thirty, .year]
    var body: some View {
        VStack {
            ForEach(0..<3) { index in
                ChartsView(data: generateData(type: datelength[index]), dataLength: datelength[index])
            }
        }
    }
}
struct ChartsView: View {
    @State var data: [DataOfCharts]
    let dataLength: DateLength
    var body: some View {
        
        Chart(data) {
            BarMark(
                x: .value("时间", $0.date2),
                y: .value("配合度", $0.animate ? $0.coopration : 0)
            )
            .foregroundStyle(Color(.white))
            
            BarMark(
                x: .value("时间", $0.date),
                y: .value("配合度", $0.animate ? $0.coopration2 : 0)
            )
            
            LineMark(
                x: .value("时间", $0.date),
                y: .value("配合度", $0.animate ? $0.coopration : 0)
            )
            
            
        }
        .background(.gray)
        .foregroundColor(.red)
        .chartYScale(domain: 0...100)
        .frame(width: 300, height: 200)
//        .chartLegend(.hidden)
//        .chartXAxis(.hidden)
//        .chartYAxis(.hidden)
//        .frame(width: 300, height: 200)
        .accessibilityElement()
        .onAppear {
            
            for (index, _) in data.enumerated() {
//                withAnimation(.easeIn(duration: 0.8)) {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(data.count - index) * 0.02) {
                    
                    withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.7)) {
                        data[index].animate = true
                    }
                }
            }
        }
    }

}
func generateData(type: DateLength = .seven) -> [DataOfCharts] {
    var day = 0
    var data = [DataOfCharts]()
    switch type {
    case.seven:
        day = 7
    case.thirty:
        day = 30
    case.year:
        day = 12
    }
    for i in 1...day {
        data.append(
            .init(coopration: .random(in: 60..<95), date: Calendar.current.date(byAdding: .day, value: 8-i, to: Date())!, coopration2: .random(in: 60..<95), date2: Calendar.current.date(byAdding: .day, value: 8-i, to: Date())!)
        )
    }
    return data
}

enum DateLength {
    case seven, thirty, year
}
//struct AXChartsOnCharts: AXChartDescriptorRepresentable {
//    let data
//    func makeChartDescriptor() -> AXChartDescriptor {
//        let xAxis = AXNumericDataAxisDescriptor(title: "数字", range: Double(0)...Double(10), gridlinePositions: []) {
//
//            "\($0)"
//        }
//
//        let yAxis = AXNumericDataAxisDescriptor(title: "身高", range: Double(0)...Double(160), gridlinePositions: []) {
//            "\($0)"
//        }
//
//        let series = AXDataSeriesDescriptor(
//            name: "图",
//            isContinuous: false,
//            dataPoints: data.map{
//                .init(x: Double($0.num), y: Double($0.Height))
//            }
//        )
//
//        return AXChartDescriptor(title: "图", summary: nil, xAxis: xAxis, yAxis: yAxis, additionalAxes: [], series: [series])
//    }
//}


struct ChartsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
