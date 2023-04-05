//
//  Landmarks.swift
//  Project10NameToFaces
//
//  Created by Frank Chu on 2/15/23.
//

import SwiftUI

struct Landmarks: View {
    var body: some View
    {
        Text("Hello")
    }
}

struct ChildView: View {
    @State private var hello = 12
    var body: some View {
        VStack {
            Text("\(hello)")
            Button("123") {
                hello = hello - 1
            }
        }
    }
}
struct Landmarks_Previews: PreviewProvider {
    static var previews: some View {
        Landmarks()
    }
}
