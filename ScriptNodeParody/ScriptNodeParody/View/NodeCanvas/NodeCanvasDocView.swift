//
//  NodeCavasDocView.swift
//  ScriptNodeParody
//
//  Created by Frank Chu on 3/25/23.
//

import SwiftUI

struct NodeCanvasDocView: View {
    @EnvironmentObject var nodePageData : NodePageData

    var body: some View {
        nodePageData
            .docView
            .frame(
                minWidth: 220,
                idealWidth: 320,
                maxWidth: .infinity,
                alignment: .top
            )
    }
}
struct NodeCavasDocView_Previews: PreviewProvider {
    static var previews: some View {
        NodeCanvasTitleIndicatorView(title: "123", indicating: .constant(true), childView: NodeCanvasDocView())
            .environmentObject(NodePageData())
            .padding()
        
    }
}
