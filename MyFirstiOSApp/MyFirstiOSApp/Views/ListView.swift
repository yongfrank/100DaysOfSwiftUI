//
//  ListView.swift
//  MyFirstiOSApp
//
//  Created by Frank Chu on 4/19/22.
//

import SwiftUI

struct ListView: View {
    @State var show = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0 ..< 5) { item in
                    ListItem()
                        .sheet(isPresented: $show, content: {
                            WhatsNew()
                        })
                        .onTapGesture {
                            show.toggle()
                        }
                }
            }
            .navigationTitle("Course")
        }
        .navigationViewStyle(.stack)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
