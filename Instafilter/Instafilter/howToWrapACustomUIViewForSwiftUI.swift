//
//  howToWrapACustomUIViewForSwiftUI.swift
//  Instafilter
//
//  Created by Frank Chu on 5/3/22.
//

import SwiftUI

struct howToWrapACustomUIViewForSwiftUI: View {
    @State var text = NSMutableAttributedString(string: "")
    
    var body: some View {
        TextViewUIKit(text: $text)
//            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

struct TextViewUIKit: UIViewRepresentable {
    @Binding var text: NSMutableAttributedString
    
    func makeUIView(context: Context) -> some UITextView {
        UITextView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.attributedText = text
    }
}

struct howToWrapACustomUIViewForSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        howToWrapACustomUIViewForSwiftUI()
    }
}
