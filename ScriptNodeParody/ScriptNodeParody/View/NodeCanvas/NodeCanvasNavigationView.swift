//
//  NodeCanvasNavigationView.swift
//  ScriptNodeParody
//
//  Created by Frank Chu on 3/25/23.
//

import SwiftUI

struct NodeCanvasNavigationView: View {
    @State private var showingAnother = false
    var body: some View {
        ZStack {
            HStack {
                NodeCanvasTitleIndicatorView(title: "Documentation", indicating: .constant(true), childView: NodeCanvasDocView())
                if showingAnother {
                    VStack {
                        Text("hihihihihihihihihihihihi")
                    }
                }
            }
            .padding(8)
            
            ZStack(alignment: .bottom) {
                HStack {
                    Button("switch") {
                        showingAnother.toggle()
                    }
                    .foregroundColor(showingAnother ? .init(UIColor.systemBackground) : .accentColor)
                    .padding(.all, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(showingAnother ? .accentColor : .clear)
                    )
                    .animation(.easeInOut, value: showingAnother)
                }
                .padding()
                .frame(height: 64)
                .background(
                    Material.regular
                )
                .mask({
                    RoundedRectangle(cornerRadius: 32)
                })
//                .padding()
                .shadow(color: .black.opacity(0.1), radius: 16, x: 0, y: 0)
                Color.clear
            }
        }
        .animation(.easeInOut, value: showingAnother)
    }
}

struct NodeCanvasNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NodeCanvasNavigationView()
            .environmentObject(NodePageData())
    }
}
