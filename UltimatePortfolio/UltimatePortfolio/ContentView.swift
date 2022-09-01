//
//  ContentView.swift
//  UltimatePortfolio
//
//  Created by Frank Chu on 8/27/22.
//

import SwiftUI

class Project: ObservableObject {
    let wrappedValue = ["Apple", "Orange", "Banana", "Cucumber"]
}

struct ContentView: View {
    @ObservedObject var project = Project()
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    Text("Apple")
                    Text("Orange")
                    Text("Banana")
                }
                .accessibilityElement(children: .ignore)
                
//                .accessibilityLabel("\(project.wrappedValue.count) items")
                
                ForEach(project.wrappedValue, id: \.self) { item in
                    Text(LocalizedStringKey(item))
                        .accessibilityAddTraits(
                            item == "orange" ? [ .isHeader, .isStaticText] : .isStaticText
                        )
                        .accessibilityHint("this is answer")
                }
                
                Button {
                    
                } label: {
                    if UIAccessibility.isVoiceOverRunning {
                        Text("Add project")
                    } else {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("Accessibility Portfolio")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
