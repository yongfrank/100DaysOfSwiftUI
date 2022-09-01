//
//  Home.swift
//  SwiftChartsDemo
//
//  Created by Frank Chu on 8/25/22.
//

import SwiftUI
import Charts

enum Tab: String {
    case seven = "7 Days", week = "Week", month = "Month"
}

struct Home: View {
    @State var sampleAnalytics: [SiteView] = SiteView.sample_analytics
    
    @State var currentTab: Tab = .seven
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("Views")
                            .fontWeight(.semibold)
                        Picker("pikcer", selection: $currentTab) {
                            Text(Tab.seven.rawValue)
                                .tag(Tab.seven)
                            Text(Tab.week.rawValue)
                                .tag(Tab.week)
                            Text(Tab.month.rawValue)
                                .tag(Tab.month)
                        }
                        .pickerStyle(.segmented)
                        .padding(.leading, 80)
                    }
                    
                    let totalValue = SiteView.calculateTotalResult(data: sampleAnalytics) ?? 0.0
                    
                    Text(totalValue.stringFormat)
                        .font(.largeTitle.bold())
                    
                    AnimatedChart()
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white.shadow(.drop(radius: 2)))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
            .navigationTitle("Swift Charts")
            .onChange(of: currentTab) { newValue in
//                sampleAnalytics = SiteView.sample_analytics
            }
        }
    }
    
    @ViewBuilder
    func AnimatedChart() -> some View {
        let max = sampleAnalytics.max { item1, item2 in
            return item2.views > item1.views
        }?.views ?? 0
        
        Chart(sampleAnalytics) {
            BarMark(
                x: .value("Hour", $0.hour, unit: .hour),
                y: .value("View", $0.animate ? $0.views : 0)
            )
        }
        .chartYScale(domain: 0...(max + 5000))
        .frame(height: 250)
        .onAppear {
            for (index, _) in sampleAnalytics.enumerated() {
                withAnimation(.easeOut(duration: 0.8).delay(Double(index) * 1)) {
                    sampleAnalytics[index].animate = true
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct SiteView: Identifiable {
    var id = UUID().uuidString
    var hour: Date
    var views: Double
    var animate: Bool = false
    
    static var sample_analytics: [SiteView] = [
        .init(hour: Date().updateHour(value: 8), views: 1500),
        .init(hour: Date().updateHour(value: 9), views: 3500),
        .init(hour: Date().updateHour(value: 10), views: 6500),
        .init(hour: Date().updateHour(value: 11), views: 2500),
        .init(hour: Date().updateHour(value: 12), views: 4500),
        .init(hour: Date().updateHour(value: 13), views: 9500),
        .init(hour: Date().updateHour(value: 14), views: 5200),
        .init(hour: Date().updateHour(value: 15), views: 5100),
        .init(hour: Date().updateHour(value: 16), views: 6500),
        .init(hour: Date().updateHour(value: 17), views: 8500),
        .init(hour: Date().updateHour(value: 18), views: 10500)
    ]
    
    static func calculateTotalResult(data: [SiteView]) -> Double? {
        return data.reduce(0.0) { partialResult, item in
            partialResult + item.views
        }
    }
}
extension Date {
    func updateHour(value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(bySettingHour: value, minute: 0, second: 0, of: self) ?? .now
    }
}

extension Double {
    var stringFormat: String {
        if self >= 1000 && self <= 999999 {
            return String(format: "%.1fK", self / 1000).replacingOccurrences(of: ".0", with: "")
        }
        if self > 999999 {
            return String(format: "%.1fM", self / 1000000).replacingOccurrences(of: ".0", with: "")
        }
        return String(format: "%.0f", self)
    }
}
