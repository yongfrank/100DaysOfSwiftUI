//
//  UnderstandingResultType.swift
//  HotProspects
//
//  Created by Frank Chu on 5/11/22.
//

import SwiftUI

struct UnderstandingResultType: View {
    @State private var output = ""
    @State private var random = 0.0
    
    var body: some View {
        Text(output)
            .task {
                await fetchReadings()
            }
    }
    
//    func fetchReadings() async {
//        do {
//            let url = URL(string: "https://hws.dev/readings.json")!
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let readings = try JSONDecoder().decode([Double].self, from: data)
//            output = "Found \(readings.count) readings"
//        } catch {
//            print("Download error")
//        }
//    }
    
    func fetchReadings() async {
        let fetchTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        let result = await fetchTask.result
        do {
            output = try result.get()
        } catch {
            output = "Error: \(error.localizedDescription)"
        }
    }
}

struct UnderstandingResultType_Previews: PreviewProvider {
    static var previews: some View {
        UnderstandingResultType()
    }
}
