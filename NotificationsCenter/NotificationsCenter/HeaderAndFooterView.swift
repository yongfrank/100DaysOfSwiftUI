//
//  HeaderAndFooterView.swift
//  NotificationsCenter
//
//  Created by Chu Yong on 5/16/23.
//

import SwiftUI

struct HeaderAndFooterView: View {
    private var text: String
    private var route: String
    private var isHeader: Bool
    var body: some View {
        HStack {
            Text(text)
            if isHeader {
                Button {
                    
                } label: {
                    Image(systemName: "questionmark.circle")
                }
            } else {
                Button("查看示例") {
                    
                }
            }
        }
    }
    init(text: String, questionMarkRoute: String) {
        self.text = text
        self.route = questionMarkRoute
        self.isHeader = true
    }
    
    init(text: String, exampleButton: String) {
        self.text = text
        self.route = exampleButton
        self.isHeader = false
    }
}

struct HeaderAndFooterView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HeaderAndFooterView(text: "App is not opened", questionMarkRoute: "hi")
            HeaderAndFooterView(text: "You can receive", exampleButton: "You can")
        }
    }
}
