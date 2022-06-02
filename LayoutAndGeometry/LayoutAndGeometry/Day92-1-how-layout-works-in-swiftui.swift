//
//  Day92-1-how-layout-works-in-swiftui.swift
//  LayoutAndGeometry
//
//  Created by Frank Chu on 5/27/22.
//

import SwiftUI

struct Day92_1_how_layout_works_in_swiftui: View {
    var body: some View {
        Text("Hello, world!")
            .padding(20)
            .background(.red)
            .padding()
//        Color.red.ignoresSafeArea()
    }
}

struct Day92_1_how_layout_works_in_swiftui_Previews: PreviewProvider {
    static var previews: some View {
        Day92_1_how_layout_works_in_swiftui()
    }
}
