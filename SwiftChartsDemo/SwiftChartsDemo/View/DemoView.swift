////
////  DemoView.swift
////  SwiftChartsDemo
////
////  Created by Frank Chu on 9/1/22.
////
//
//import SwiftUI
//import Charts
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
////            Text("")
//            DemoView()
//                .frame(width: 350, height: 350, alignment: .center)
//        }
//    }
//}
//
//struct Shape: Identifiable {
//    var type: String
//    var count: Double
//    var id = UUID()
//}
//
//let data: [Shape] = [
//    .init(type: "Square",    count: 12),
//    .init(type: "Heart",     count: 10),
//    .init(type: "Rectangle", count: 21),
//    .init(type: "Star",      count: 15),
//    .init(type: "ircle",    count: 8),
//    .init(type: "Tiangle",  count: 6),
//    .init(type: "Retangle", count: 21),
//    .init(type: "tar",      count: 15),
//    .init(type: "Crcle",    count: 8),
//    .init(type: "Trngle",  count: 6),
//    .init(type: "ectangle", count: 21),
//    .init(type: "Sar",      count: 15),
//    .init(type: "Cicle",    count: 8),
//    .init(type: "Trigle",  count: 6),
//]
//
//struct DemoView: View {
//    var body: some View {
//        Chart {
//            ForEach (data) { shape in
//                BarMark (
//                    x: .value("Shape", shape.type),
//                    y: .value("Count", shape.count)
//                )
////                .foregroundStyle(by: .value("Shape", shape.type))
//            }
//        }
//        
////        .chartXAxis(.hidden)
////        .chartYAxis(.hidden)
////        .chartLegend(.hidden)
//    }
//}
//
////struct Profit: Identifiable {
////    let id = UUID()
////    let department: String
////    let profit: Double
////}
////
////let data: [Profit] = [
////    Profit(department: "Production", profit: 15000),
////    Profit(department: "Marketing", profit: 8000),
////    Profit(department: "Finance", profit: 10000)
////]
////struct DemoView: View {
////    var body: some View {
////        VStack {
////            Text("Hello World")
////            Chart(data) {
////                BarMark(
////                    x: .value("部门", $0.department),
////                    y: .value("营收", $0.profit)
////                )
////            }
//////                        .accessibilityChartDescriptor(MyChartDescriptorRepresentable())
////
////            .padding()
////            .frame(height: 140)
////        }
////    }
////}
//
////struct MyChartDescriptorRepresentable: AXChartDescriptorRepresentable {
////    func makeChartDescriptor() -> AXChartDescriptor {
////        // Build and return your `AXChartDescriptor` here.
////
////        let xAxis = AXNumericDataAxisDescriptor(
////            title: "部门",
////            range: Double(0)...Double(2),
////            gridlinePositions: []) { index in
////                ["Production", "Marketing", "Finance"][Int(index)]
////            }
////        let yAxis = AXNumericDataAxisDescriptor(
////            title: "营收",
////            range: Double(0)...Double(15000),
////            gridlinePositions: []) {
////                "\($0)"
////            }
////
////
////        let series = AXDataSeriesDescriptor(name: "营销", isContinuous: false, dataPoints: data.enumerated().map({ (index, data) in
////                .init(x: Double(index), y: Double(data.profit))
////            //                .init(x: Double(index))
////        })
////        )
////
////        return AXChartDescriptor(
////            title: "What",
////            summary: "Idont know",
////            xAxis: xAxis,
////            yAxis: yAxis, additionalAxes: [], series: [series]
////        )
////    }
////
////    func updateChartDescriptor(_ descriptor: AXChartDescriptor) {
////        // Update your chart descriptor with any new values.
////    }
////}
//
//struct DemoView_Previews: PreviewProvider {
//    static var previews: some View {
//        DemoView()
//    }
//}
