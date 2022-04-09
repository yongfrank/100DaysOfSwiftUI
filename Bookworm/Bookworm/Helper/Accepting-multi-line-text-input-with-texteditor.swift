//
//  Accepting-multi-line-text-input-with-texteditor.swift
//  Bookworm
//
//  Created by Frank Chu on 4/5/22.
//  https://www.hackingwithswift.com/books/ios-swiftui/accepting-multi-line-text-input-with-texteditor

import SwiftUI

struct Accepting_multi_line_text_input_with_texteditor: View {
    
    @AppStorage("IDontKnowWhatThis") private var varNotes = "Write something here \n"
    
    var body: some View {
        NavigationView {
            TextEditor(text: $varNotes)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

struct Accepting_multi_line_text_input_with_texteditor_Previews: PreviewProvider {
    static var previews: some View {
        Accepting_multi_line_text_input_with_texteditor()
    }
}
