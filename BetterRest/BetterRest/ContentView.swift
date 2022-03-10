//
//  ContentView.swift
//  BetterRest
//
//  Created by Frank Chu on 3/10/22.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    // adding three properties that determine the title and message of the alert,
    // and whether or not it’s showing:
    // https://www.hackingwithswift.com/books/ios-swiftui/connecting-swiftui-to-core-ml
    
    @State private var alertTitle = ""
//    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var calculateBedtime: String{
        var alertMessage = ""
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
//            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
//            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            
        }
//        showingAlert = true
        return alertMessage
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
    //                Text(wakeUp.formatted())
                    Section("When do you want to wake up?") {
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    
                    Section {
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    } header: {
                        Text("Desired amount of sleep")
    //                        .font(.largeTitle)
    //                        .font(.headline)
                    }
                    
                    Section {
                        Text("Daily coffee intake")
                            .font(.headline)
                        
                        Stepper((coffeeAmount == 1 || coffeeAmount == 0) ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                        
                        Picker((coffeeAmount == 1 || coffeeAmount == 0) ? "1 cup" : "\(coffeeAmount) cups", selection: $coffeeAmount) {
                            ForEach(0..<21) {
                                Text((coffeeAmount == 1 || coffeeAmount == 0) ? "\($0) cup" : "\($0) cups")
                            }
                        }
                    }
                }
                Spacer()
                VStack {
                    Text("Recommended Bedtime")
                        .font(.caption)
                    Text(calculateBedtime)
                        .font(.largeTitle.bold())
                }
                
            }
            .navigationTitle("BetterRest")
//            .toolbar {
//                Button("Calculate", action: calculateBedtime)
//                Text("\(alertMessage)")
//                    .font(.largeTitle)
//            }
//            .alert(alertTitle, isPresented: $showingAlert) {
//                Button("OKOK") { }
//            } message: {
//                Text(alertMessage)
//            }
//            .preferredColorScheme(.dark)
            // end of VStack
            
            
        }
        
        // end of NavigationView
        
        
    } // end of var body: some View
    
//    func calculateBedtime(){
//        do {
//            let config = MLModelConfiguration()
//            let model = try SleepCalculator(configuration: config)
//
//            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
//            let hour = (components.hour ?? 0) * 60 * 60
//            let minute = (components.minute ?? 0) * 60
//
//            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
//
//            let sleepTime = wakeUp - prediction.actualSleep
//
//            alertTitle = "Your ideal bedtime is..."
//            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
//        } catch {
//            alertTitle = "Error"
//            alertMessage = "Sorry, there was a problem calculating your bedtime."
//        }
//        showingAlert = true
//
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

