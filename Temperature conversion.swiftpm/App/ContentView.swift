//
//  ContentView.swift
//  temperatureConversion
//
//  Created by Frank Chu on 2/28/22.
//

import SwiftUI

struct ContentView: View {
    let units = ["°C", "°F", "K"]
    
    //type annotation learned on #100DaysOfSwiftUI day 4
    @State private var inputNumber = 10.0
    @State private var inputUnit = "°C"
    @State private var outputUnit = "°F"
    @FocusState private var textFieldIsFocused: Bool
    
    var outputNumber: Double {
//        let unitSelection: Double
        let conversionNumber: Double
        let temperatureInK: Double
        let kelvinNumber = 273.15
        
        
        if inputUnit == "°C" {
            temperatureInK = inputNumber + kelvinNumber
        } else if inputUnit == "°F" {
            temperatureInK = (inputNumber - 32) / 1.8 + kelvinNumber
        } else {
            temperatureInK = inputNumber
        }
        
        if outputUnit == "°C" {
            conversionNumber = temperatureInK - kelvinNumber
        } else if outputUnit == "°F" {
            conversionNumber = (temperatureInK - kelvinNumber) * 1.8 + 32
        } else {
            conversionNumber = temperatureInK
        }
        
        
        return conversionNumber
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Choose your input unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                        
                    }
//                    Text("Your input unit is \(inputUnit)")
                    
                }
                Section {
                    TextField("Input temperature", value: $inputNumber, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($textFieldIsFocused)
                } header: {
                    Text("Input temperature in \(inputUnit)")
                }
                
                Section {
                    Picker("Choose your output unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    Text(outputNumber, format: .number)
                } header: {
                    Text("Output temperature in \(outputUnit)")
                }
            }
            .navigationTitle("🌡 Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        textFieldIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
