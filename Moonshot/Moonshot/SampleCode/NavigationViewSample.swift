//
//  NavigationViewSample.swift
//  Moonshot
//
//  Created by Frank Chu on 3/17/22.
//

import SwiftUI

struct NavigationViewSample: View {
    var body: some View {
        NavigationView {
            List(0..<100) { row in
                NavigationLink {
                    Text("Detail \(row)")
                } label: {
                    Text("Row \(row)")
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}

struct NavigationViewSample_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewSample()
    }
}
