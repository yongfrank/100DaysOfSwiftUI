//
//  NodeCanvasTitleIndicatorView.swift
//  ScriptNodeParody
//
//  Created by Frank Chu on 3/25/23.
//

import SwiftUI

struct NodeCanvasTitleIndicatorView<ChildrenView: View>: View {
    
    @State var title : String = ""
    @Binding var indicating : Bool
    
    var childView: ChildrenView
    
    var body: some View {
        ZStack(alignment: .top) {
            childView
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(indicating
                                ? Color.init(UIColor.quaternaryLabel)
                                : Color.clear,
                                lineWidth: indicating ? 8 : 0
                       )
                )
                .mask(RoundedRectangle(cornerRadius: 16))
            
            Text("\(title)")
                .font(.body.monospaced())
                .padding()
                .background(Material.thin)
                .frame(height: 32)
                .cornerRadius(32)
                .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 0)
                .opacity(indicating ? 1 : 0)
                .padding(.top, 32)

        }
//        .animation(.easeOut, value: indicating)
    }
}

struct NodeCanvasTitleIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        NodeCanvasTitleIndicatorView(
            title: "Editor",
            indicating: .constant(true),
            childView: EditorView()
        )
        .padding()
    }
}

struct EditorView: View {
    var body: some View {
        List {
            Section {
                Text("👾 How to make games with Pegboard")
                    .font(.title2.monospaced())
                Text("🏵 Chapter 3 - Full-on Flappy Bird")
                    .font(.subheadline.monospaced())
            } header: {
                VStack(alignment: .leading) {
                    Color.clear.frame(height: 20)
                    Text("TITLE")
                }
            }
            
            Section {
                Text("🙃 OK I know this will be too much, so I am doing it myself this time! All the nodes are already working, just enjoy playing it!")
                    .font(.footnote.monospaced())
                Text("👀 What you are seeing is the full potential of Pegboard for game dev on an iPad, it is fully interactive, not a single line of code to the user side, and fun to use (just drag and drop).")
                    .font(.footnote.monospaced())
            } header: {
                Text("NODES RULE IT ALL")
            }
            
            Section {
                Text("🎉 Thank you for using Pegboard! Hope this one will get you interested into the game development and the world of ode-editor based programming!")
                    .font(.footnote.monospaced())
                
                Text("🎉 And remember, Pegboard is more than just a game development framework as demostrated here. It can be used in music production, Shortcuts-like automation, visual story-telling, and much much more. The framework is capable of doing all that, and the only limitation is the user.")
                    .font(.footnote.monospaced())
            } header: {
                Text("BYE!")
            }
        }
    }
}
