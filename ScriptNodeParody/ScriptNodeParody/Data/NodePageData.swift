//
//  NodePageData.swift
//  ScriptNodeParody
//
//  Created by Frank Chu on 3/25/23.
//

import Foundation
import SwiftUI

protocol NodePageDataProvider {
    func modifyCanvas(nodePageData : NodePageData)
    func modifyDocView(nodePageData: NodePageData)
    func modifyLiveScene(nodePageData : NodePageData)
    func cheat(nodePageData : NodePageData)
    func destroy(nodePageData : NodePageData)
}

protocol NodePageDataObject {
    func reset()
    func switchTo(index : Int)
}


class NodePageData: ObservableObject, NodePageDataObject {
    
    @Published var docView : AnyView
    
    var modifier : NodePageDataProvider = NodePageDataProviderChapterZero()
    
    init() {
        docView = AnyView(ZStack{})
        reset()
    }
    
    func reset() {
        self.modifier.modifyCanvas(nodePageData: self)
        
        self.modifier.modifyDocView(nodePageData: self)
        
        self.modifier.modifyLiveScene(nodePageData: self)
    }
    
    func switchTo(index: Int) {
        self.modifier.destroy(nodePageData: self)
        
        switch index {
        case 0:
            modifier = NodePageDataProviderChapterZero()
        case 1:
            modifier = NodePageDataProviderChapterOne()
        default:
            break
        }
        
        self.reset()
    }
}
class NodePageDataProviderChapterOne : NodePageDataProvider {
    
    func modifyCanvas(nodePageData: NodePageData) {
        
    }
    
    func modifyDocView(nodePageData: NodePageData) {
        nodePageData.docView = AnyView (
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

                
                Section {
                    Button {
                        nodePageData.switchTo(index: 0)
                    } label: {
                        Label("Previous Chapter", systemImage: "arrow.left")
                            .font(.body.monospaced())
                    }
                } header: {
                    Text("CONTEXT")
                }

            }
        )
    }
    
    func modifyLiveScene(nodePageData: NodePageData) {
        
    }
    
    func cheat(nodePageData: NodePageData) {
        
    }
    
    func destroy(nodePageData: NodePageData) {
        
    }
    
    
}

class NodePageDataProviderChapterZero : NodePageDataProvider {
    func modifyCanvas(nodePageData: NodePageData) {
        
    }
    
    func modifyDocView(nodePageData: NodePageData) {
        nodePageData.docView = AnyView (
            AnyView(
                List {
                    Section {
                        Text("👾 How to make games with Pegboard")
                            .font(.title2.monospaced())
                        Text("🖇 Chapter 0 - Pegboard?")
                            .font(.subheadline.monospaced())
                    } header: {
                        VStack(alignment: .leading) {
                            Color.clear.frame(height: 20)
                            Text("TITLE")
                        }
                    }
                    
                    Section {
                        Button {
                            nodePageData.switchTo(index: 1)
                        } label: {
                            Label("Next Chapter", systemImage: "arrow.right")
                                .font(.body.bold().monospaced())
                        }
                    } header: {
                        Text("CONTEXT")
                    }
                }
            )
        )
    }
    
    func modifyLiveScene(nodePageData: NodePageData) {
        
    }
    
    func cheat(nodePageData: NodePageData) {
        
    }
    
    func destroy(nodePageData: NodePageData) {
        
    }
}
