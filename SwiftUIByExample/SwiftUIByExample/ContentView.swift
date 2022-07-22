//
//  ContentView.swift
//  SwiftUIByExample
//
//  Created by Frank Chu on 7/16/22.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @Binding var document: TextFile
    
    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct TextFile: FileDocument {
    static var readableContentTypes: [UTType] = [UTType.plainText]
    
    var text = "HI, This App is created by Frank"
    
    init(initialText: String = "") {
        text = initialText
    }
    
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}
