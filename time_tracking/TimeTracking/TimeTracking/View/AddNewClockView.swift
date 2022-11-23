//
//  AddNewClockView.swift
//  TimeTracking
//
//  Created by Frank Chu on 10/22/22.
//

import SwiftUI

struct AddNewClockView: View {
    @Binding var sheetShown: Bool
    @State var clockName: String = ""
    @State var color = Color.blue
    
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        VStack {
            Text("Add New Clock")
                .font(.title)
            HStack {
                VStack {
                    /// `public init(_ titleKey: LocalizedStringKey, text: Binding<String>)`
                    TextField("Clock name", text: $clockName)
                        .frame(width: 150)
                        .textFieldStyle(.roundedBorder)
                    /// `    public static var plain: PlainTextFieldStyle { get }`
                    //                        .textFieldStyle(.plain)
                    /// `public struct PlainTextFieldStyle : TextFieldStyle`
                    //                        .textFieldStyle(PlainTextFieldStyle())
                    //                        .padding(.bottom, 3)
                    //                    Rectangle().frame(height: 1).foregroundColor(.gray)
                }
                .padding(10)
                
                /// `public init(_ titleKey: LocalizedStringKey, selection: Binding<Color>, supportsOpacity: Bool = true)`
                ColorPicker("", selection: $color, supportsOpacity: false)
            }
            HStack {
                Button(action: { sheetShown = false }) {
                    Text("Cancel")
                }
                
                Button(action: {
                    print("Adding new clock")
                    self.env.clocks.append(Clock(name: clockName, color: color))
                    print(self.env.clocks)
                    self.sheetShown = false
                }) {
                    
                    Text("Add")
                        .foregroundColor(.green)
                }
            }
        }
    }
}

struct AddNewClockView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewClockView(sheetShown: .constant(true))
            .environmentObject(GlobalEnvironment())
    }
}
