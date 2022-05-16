//
//  CreatingContextMenu.swift
//  HotProspects
//
//  Created by Frank Chu on 5/12/22.
//

import SwiftUI

struct CreatingContextMenu: View {
    
    @State private var backgroundColor = Color.red
    
    var body: some View {
        VStack {
            Text("Hello World")
                .padding()
                .background(backgroundColor)
            Text("Change Color")
                .padding()
                .contextMenu {
                    Button {
                        backgroundColor = .red
                    } label: {
                        Label("Red", systemImage: "checkmark.circle.fill")
                            .foregroundColor(.red)
                    }
                    
                    Button("Green") {
                        backgroundColor = .green
                    }
                    Button("Blue") {
                        backgroundColor = .blue
                    }
                }
        }
    }
}

struct CreatingContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        CreatingContextMenu()
    }
}
