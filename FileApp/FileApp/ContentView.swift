//
//  ContentView.swift
//  FileApp
//
//  Created by Frank Chu on 7/16/22.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var isOpenFileInterface = false
    @State private var isSaveFile = false
    @State private var fileName = "TEST"
    
    var body: some View {
        VStack {
            Text(fileName)
                .fontWeight(.bold)
            Button("Open File") {
                isOpenFileInterface.toggle()
            }
            Button("Save File") {
                isSaveFile.toggle()
            }
        }
        .fileImporter(isPresented: $isOpenFileInterface, allowedContentTypes: [.item]) { result in
            switch result {
            case .success(let url):
                print("DEBUG: url is", url)
                fileName = url.lastPathComponent
            case .failure(let error):
                print("DEBUG: error is", error.localizedDescription)
            }
        }
        .fileExporter(isPresented: $isSaveFile, document: Doc(url: Bundle.main.path(forResource: "running", ofType: "jpeg")!), contentType: .item) { result in
            switch result {
            case .success(let url):
                print("DEBUG: FILE EXPORTER", url)
            case .failure(let error):
                print("DEBUG: Exporter", error.localizedDescription)
            }
        }
        .onAppear {
            print("DEBUG: Bundle.main.path", Bundle.main.path(forResource: "running", ofType: "jpeg")!)
        }
    }
}
struct Doc: FileDocument {
    var url: String
    
    static var readableContentTypes: [UTType] {
        [.item]
    }

    init(url: String) {
        self.url = url
    }
    
    init(configuration: ReadConfiguration) throws {
        url = ""
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let file = try! FileWrapper(url: URL(filePath: url), options: .immediate)
        return file
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

