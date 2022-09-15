////
////  ChartViewDemo.swift
////  SwiftChartsDemo
////
////  Created by Frank Chu on 9/1/22.
////
//
//import SwiftUI
//import Charts
//
//enum Model: String {
//    case iphone = "iPhone", ipad = "iPad", watch = "Apple Watch", tv = "Apple TV"
//}
//
//struct ChartStatics {
//    var model: Model
//    var sales: Int = .random(in: 300...10000)
//}
//
//var sampleStatics: [ChartStatics] = [
//    .init(model: .ipad),
//    .init(model: .iphone),
//    .init(model: .tv),
//    .init(model: .watch)
//]
//
//struct ChartViewDemo: View {
//    
//    @State var sampleCharts = sampleStatics
//    var body: some View {
//        VStack {
//            Text("hello world")
////            Chart(sampleStatics) {
////                BarMark(x: .value("Model", $0.model.rawValue),
////                        y: .value("Sales", $0.sales)
////                )
////            }
//        }
//    }
//}
//
//struct ChartViewDemo_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartViewDemo()
//    }
//}
