//
//  ContentView.swift
//  SwiftChartDelune
//
//  Created by Frank Chu on 8/25/22.
//

import SwiftUI
import Charts

struct Note: Identifiable {
    let time: Double
    let value: Double
    let id = UUID()
    
}

struct ContentView: View, AXChartDescriptorRepresentable {
    func makeChartDescriptor() -> AXChartDescriptor {
        let maxTime = song.map(\.time).max() ?? 0.0
        
        let xAxis = AXNumericDataAxisDescriptor(
            title: "Time",
            range: Double(0)...Double(maxTime),
            gridlinePositions: []) {
                "\($0) seconds"
            }
        let yAxis = AXNumericDataAxisDescriptor(
            title: "Value",
            range: 0...100,
            gridlinePositions: []
        ) { "\($0)" }
        
        let series = AXDataSeriesDescriptor(name: "Song", isContinuous: false, dataPoints: song.map({
            .init(x: Double($0.time), y: Double($0.value))
        }))
        
        return AXChartDescriptor(
            title: "Song",
            summary: nil,
            xAxis: xAxis,
            yAxis: yAxis,
            additionalAxes: [],
            series: [series]
        )
    }
    
    let song = songGenerator()
    var body: some View {
        NavigationStack {
            ScrollView {
                Chart(song) {
                    LineMark(
                        x: .value("Time", $0.time),
                        y: .value("Value", $0.value)
                    )
                    .lineStyle(StrokeStyle(lineWidth: 3))
                    .symbol(Circle())
                    .foregroundStyle(.black)
//                    .interpolationMethod(.cardinal)
                }
//                .chartYScale(domain: 0...100)
//                .chartXScale(domain: 0...50)
                .frame(height: 300)
                .accessibilityElement()
                .accessibilityChartDescriptor(self)
                .padding()
            }
            .navigationTitle("Chart de lune 🎵")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func songGenerator() -> [Note] {
    let song: [Note] = [
        .init(time: 0, value: 37.5), // G
        .init(time: 1, value: 100), // G+

        .init(time: 4, value: 85), // E+

        .init(time: 7, value: 27.5), // F
        .init(time: 8, value: 75), // D+
        .init(time: 9, value: 85), // E+
        .init(time: 10, value: 75), // D+

        .init(time: 13, value: 25), // E
        .init(time: 14, value: 65), // C+
        .init(time: 15, value: 75), // D+
        .init(time: 16, value: 65), // C+
        .init(time: 17, value: 85), // E+

        .init(time: 20, value: 65), // C+

        .init(time: 23, value: 5), // D
        .init(time: 24, value: 60), // B+
        .init(time: 25, value: 65), // C+
        .init(time: 26, value: 60), // B+

        .init(time: 29, value: 0), // C
        .init(time: 30, value: 47.5), // A+
        .init(time: 31, value: 60), // B+
        .init(time: 32, value: 47.5), // A+
        .init(time: 33, value: 75), // D+
        .init(time: 34, value: 47.5), // A+
        .init(time: 35, value: 37.5), // G
        .init(time: 36, value: 47.5), // A+
        .init(time: 37, value: 37.5), // G
        .init(time: 38, value: 27.5), // F
        .init(time: 39, value: 37.5), // G
        .init(time: 40, value: 27.5), // F

        .init(time: 43, value: 20), // E
    ]
    return song
}
