//
//  ContentView.swift
//  WeSplit
//
//  Created by Frank Chu on 2/28/22.
//
import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var dollarFormat: FloatingPointFormatStyle<Double>.Currency {
        let currencyCode = Locale.current.currencyCode ?? "USD"
        return FloatingPointFormatStyle<Double>.Currency(code: currencyCode)
    }
  
    var totalPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amoutPerPerson = grandTotal / peopleCount
        
        return amoutPerPerson
    }
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(0 ..< 100) {
                            Text("\($0) people")
                        }
                    }
//                    .pickerStyle(.segmented)
                }
                
                Section {
//                    Text("How much tip do you want to leave?")
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< 101) {
                            Text($0, format: .percent)
                        }
                    }
//                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerson, format: dollarFormat)
                } header: {
                    Text("Amount per person")
                }
                
                Section {
                    Text(totalAmount, format: dollarFormat)
                } header: {
                    Text("Original amount plus tip value")
                }
            }
            .navigationTitle("WeSplit")
//            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
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
