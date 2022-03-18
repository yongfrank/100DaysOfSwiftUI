//
//  ScrollViewSample.swift
//  Moonshot
//
//  Created by Frank Chu on 3/17/22.
//

import SwiftUI

struct CustomText: View {
    let text: String

    var body: some View {
        Text(text)
    }

    init(_ text: String) {
        print("Creating a new CustomText")
        self.text = text
    }
}

struct ScrollViewSample: View {
    var body: some View {
//        ScrollView {
//            VStack(spacing: 10) {
//                ForEach(0..<101) {
//                    Text("Item \($0)")
//                        .font(.title)
//                }
//            }
//            .frame(maxWidth: .infinity)
//        }
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(0..<100) {
                    CustomText("Item \($0)")
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct ScrollViewSample_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewSample()
    }
}
