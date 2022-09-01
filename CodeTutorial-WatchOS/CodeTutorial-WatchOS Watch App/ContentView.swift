//
//  ContentView.swift
//  CodeTutorial-WatchOS Watch App
//
//  Created by Frank Chu on 8/26/22.
//

import SwiftUI

struct ContentView: View {
    let timerChoose = [5, 10, 20, 30, 60]
    @State private var timerValue = 5
    
    @State private var path = [Int]()
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Text("Start for \(timerValue) seconds")
                Picker("", selection: $timerValue) {
                    ForEach(timerChoose, id: \.self) { num in
                        Text("\(num) seconds")
                    }
                }
                Button("Go") {
                    path.append(timerValue)
                }
            }
            .navigationDestination(for: Int.self) { num in
                SecondView(num: num, path: $path, timeVal: num)
            }
        }
    }
}

struct SecondView: View {
    let num: Int
    @Binding var path: [Int]
    
    @State var timeVal: Int
    var body: some View {
        VStack {
            Text("Timer Remaining")
                .font(.system(size: 14))
            Text("\(timeVal)")
                .font(.system(size: 40))
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                        if self.timeVal > 0 {
                            self.timeVal -= 1
                        }
                    }
                }
            Text("seconds")
                .font(.system(size: 14))
            
            Button {
                path.remove(at: 0)
            } label: {
                Text(timeVal > 0 ? "Cancel" : "Done")
                    .foregroundColor(timeVal > 0 ? .red : .green)
            }
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(num: 10, path: .constant([2]), timeVal: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
