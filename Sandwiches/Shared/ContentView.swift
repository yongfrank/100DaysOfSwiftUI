//
//  ContentView.swift
//  Shared
//
//  Created by Frank Chu on 4/9/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store: SandwichStore
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.sandwiches) { sandwich in
                    SandwichCell(sandwich: sandwich)
                }
                .onMove(perform: moveSandwiches)
                .onDelete(perform: deleteSandwiches)
                HStack {
                    Spacer()
                    Text("\(store.sandwiches.count) Sanwiches")
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            .navigationTitle("Sandwiches")
            .toolbar {
                HStack {
                    Button("Add", action: makeSandwich)
//                    Spacer()
                    #if os(iOS)
                    EditButton()
                    #endif
                }
            }
            
            Text("Select a sandwich")
                .font(.largeTitle)
        }
    }
    
    func makeSandwich() {
        withAnimation {
            store.sandwiches.append(Sandwich(name: "Patty melt", ingredientCount: 3))
        }
    }
    
    func moveSandwiches(from: IndexSet, to: Int) {
        withAnimation {
            store.sandwiches.move(fromOffsets: from, toOffset: to)
        }
    }
    
    func deleteSandwiches(offsets: IndexSet) {
        withAnimation {
            store.sandwiches.remove(atOffsets: offsets)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: SandwichStore(sandwiches: testData))
    }
}

struct SandwichCell: View {
    var sandwich: Sandwich
    
    var body: some View {
        NavigationLink(destination: SandwichDetail(sandwich: sandwich)) {
            HStack {
                //                Image(sandwich.thumbnailName)
//                GeometryReader { geoTemp in
//                    Image("catAvater")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: geoTemp.size.width * 0.3)
//                }
                
                Image("catAvater")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .scaledToFill()
                    .cornerRadius(8)
                VStack(alignment: .leading) {
                    Text(sandwich.name)
                    Text("\(sandwich.ingredientCount) ingredient")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    
                }
            }
        }
    }
}
