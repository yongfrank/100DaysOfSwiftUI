//
//  Day81AddingCustomRow.swift
//  HotProspects
//
//  Created by Frank Chu on 5/12/22.
//

import SwiftUI

struct Day81AddingCustomRow: View {
    var body: some View {
        List {
            Text("Taylor Swift")
                .swipeActions {
                    Button {
                        print("Hi")
                    } label: {
                        Label("Send message", systemImage: "message")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button(role: .destructive) {
                        print("Hi")
                    } label: {
                        Label("pin", systemImage: "pin")
                    }
                    .tint(.orange)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        print("Hi")
                    } label: {
                        Label("delete", systemImage: "minus.circle")
                    }
                }
        }
    }
}

struct Day81AddingCustomRow_Previews: PreviewProvider {
    static var previews: some View {
        Day81AddingCustomRow()
    }
}
