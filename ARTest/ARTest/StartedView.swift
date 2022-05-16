//
//  StartedView.swift
//  ARTest
//
//  Created by Frank Chu on 5/1/22.
//

import SwiftUI

struct StartedView: View {
    @Binding var isStarted: Bool
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                Button {
                    isStarted.toggle()
                } label: {
                    Text("Start")
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

//struct StartedView_Previews: PreviewProvider {
//    static var previews: some View {
//        StartedView(isStarted: .constant(false))
//    }
//}
