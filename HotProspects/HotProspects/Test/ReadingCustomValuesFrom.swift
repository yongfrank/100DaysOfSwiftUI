//
//  ReadingCustomValuesFrom.swift
//  HotProspects
//
//  Created by Frank Chu on 5/5/22.
//

import SwiftUI
//@MainActor
class SomeValue: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct ReadingCustomValuesFrom: View {
    @StateObject var someValue: SomeValue
    static let tagHI = "twt"
    
    @State var selectedTab = "One"
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            VStack {
                SubViewFirst()
                SubViewSecond()
                    .onTapGesture {
                        selectedTab = "Two"
                    }
                Button("Change to frank") {
                    selectedTab = "Two"
                }
            }
            .tabItem {
                Label("One", systemImage: "star")
            }
            .tag("One")
            
            VStack {
                Text("Tab two, tap to change to tab one")
                    .onTapGesture {
                        selectedTab = "One"
                    }
            }
            .tabItem {
                Label("Two", systemImage: "circle")
            }
            .tag("Two")
        }
        .environmentObject(someValue)
    }
}

struct SubViewFirst: View {
    @EnvironmentObject var someValue: SomeValue
    var body: some View {
        TextField("Name", text: $someValue.name)
    }
}

struct SubViewSecond: View {
    @EnvironmentObject var someValue: SomeValue
    var body: some View {
        Text(someValue.name)
    }
}

struct ReadingCustomValuesFrom_Previews: PreviewProvider {
    static var previews: some View {
        ReadingCustomValuesFrom(someValue: SomeValue())
    }
}
