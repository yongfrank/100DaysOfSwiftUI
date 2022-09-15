////
////  ContentView.swift
////  SwiftChartsDemo
////
////  Created by Frank Chu on 8/25/22.
////
//
//import SwiftUI
//import Charts
//import Accessibility
//import Foundation
//
//struct Item: Identifiable {
//    var id = UUID()
//    let type: String
//    let value: Double
//}
//
//struct ContentView: View, AXChartDescriptorRepresentable {
//    func makeChartDescriptor() -> AXChartDescriptor {
//        
//        let xAxis = AXNumericDataAxisDescriptor(title: "职位", range: Double(0)...Double(4), gridlinePositions: []) {
//            "\($0) Positon"
//        }
//        
//        let yAxis = AXNumericDataAxisDescriptor(title: "营收", range: Double(0)...Double(150), gridlinePositions: []) {
//            "\($0)"
//        }
//        
//        let series = AXDataSeriesDescriptor(
//            name: "职位营收",
//            isContinuous: false,
//            dataPoints: items.map {
//                .init(x: Double($0.value * 2), y: Double($0.value))
//            }
//        )
//        
//        return AXChartDescriptor(
//            title: "职业",
//            summary: nil,
//            xAxis: xAxis,
//            yAxis: yAxis,
//            additionalAxes: [],
//            series: [series]
//        )
//    }
//    
//    
//    
//    
//    let items: [Item] = [
//        .init(type: "Engineering", value: 100),
//        .init(type: "Design", value: 35),
//        .init(type: "Operations", value: 72),
//        .init(type: "Sales", value: 22),
//        .init(type: "Mgmt", value: 130)
//        
//    ]
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                Chart(items) { item in
//                    LineMark(
//                        x: .value("Department", item.type),
//                        y: .value("Profit", item.value)
//                    )
//                    .lineStyle(StrokeStyle(lineWidth: 3))
//                    .symbol(Circle())
//                    .foregroundStyle(.blue.gradient)
////                    .interpolationMethod(.cardinal)
//                }
//                .accessibilityElement()
//                .accessibilityChartDescriptor(self)
//                .frame(height: 200)
//                .padding()
//                
//                Chart(items) { item in
//                    AreaMark(
//                        x: .value("Department", item.type),
//                        y: .value("Profit", item.value)
//                    )
//                    .foregroundStyle(.green.gradient)
//                }
//                .accessibilityElement()
//                .accessibilityChartDescriptor(self)
//                .frame(height: 200)
//                .padding()
//                
//                Chart(items) { item in
//                    PointMark(
//                        x: .value("Department", item.type),
//                        y: .value("Profit", item.value)
//                    )
//                    .foregroundStyle(.red.gradient)
//                }
//                .accessibilityElement()
//                .accessibilityChartDescriptor(self)
//                .frame(height: 200)
//                .padding()
//                
//                
//                
//            }
//            .navigationTitle("Charts")
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
