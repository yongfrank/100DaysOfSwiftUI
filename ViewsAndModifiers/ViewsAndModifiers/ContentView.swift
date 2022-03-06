//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Frank Chu on 3/4/22.
//  Project 3 Day 23

import SwiftUI



// This is custom containers
struct GridStack <Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content
    
    var body: some View {
        // more to come
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
                
            }
        }
    }
}
// Custom containers end here
  
struct CapsuleView: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(.blue)
            .clipShape(Capsule())
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

// Watermark make
struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}
// Watermark make ends here

struct LargeBlueFont: ViewModifier {
    var stateColor = false
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(stateColor ? .red : .white)
            .buttonStyle(.borderedProminent)
    }
}

extension View {
    func largeBlueButton(with stateColor: Bool) -> some View {
        modifier(LargeBlueFont(stateColor: stateColor))
    }
}
struct ContentView: View {
    @State private var buttonColor = false
    var body: some View {
        TabView {
            
            ScrollView {
                VStack(spacing: 10) {
                    Color.blue
                        .frame(width: 300, height: 200)
                        .watermarked(with: "Hacking with Swift")
                    
                    CapsuleView(text: "First")
                        .foregroundColor(.white)
                    CapsuleView(text: "Second")
                        .foregroundColor(.yellow)
                    Text("Hello, world!")
                        .modifier(Title())
                    Text("Hello, world!")
                        .titleStyle()
                    
                    GridStack(rows: 4, columns: 4) { row, col in
                        Image(systemName: "\(row * 4 + col).circle")
                        Text("R\(row) C\(col)")
                    }
                    
                    Button("Hello, world") {
                        buttonColor.toggle()
                    }
                    .largeBlueButton(with: buttonColor)
                    .watermarked(with: "Created by Frank")
                    Button("Hello, world") {
                        buttonColor.toggle()
                    }
                    .largeBlueButton(with: buttonColor)
                }
            }
            .tabItem {
                Label("Home", systemImage: "person")
            }
            
            VStack {
                Button("Hello, world") {
                    buttonColor.toggle()
                }
                .largeBlueButton(with: buttonColor)
            }
            .tabItem {
                Label("Favorites", systemImage: "star")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
