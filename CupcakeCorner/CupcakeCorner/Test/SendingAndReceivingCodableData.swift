//
//  SendingAndReceivingCodableData.swift
//  CupcakeCorner
//
//  Created by Frank Chu on 4/1/22.
//  https://www.hackingwithswift.com/books/ios-swiftui/sending-and-receiving-codable-data-with-urlsession-and-swiftui

import SwiftUI

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct Response: Codable {
    var results: [Result]
}

struct SendingAndReceivingCodableData: View {
    
    @State private var results = [Result]()
    @State private var inputSomething = ""
    @State private var urlInput = "https://itunes.apple.com/search?term=lady+gaga&entity=song"
    
    var body: some View {
        VStack {
            TextField("Artists, Songs, Lyrics, and More", text: $inputSomething)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            Button("Search") {
                inputSomething = inputSomething.replacingOccurrences(of: " ", with: "+")
                urlInput = "https://itunes.apple.com/search?term=\(inputSomething)&entity=song"
                Task {
                    await loadData()
                }
            }
            
            List(results, id: \.trackId) { item in
                VStack(alignment: .leading) {
                    Text(item.trackName)
                        .font(.headline)
                    Text(item.collectionName)
                }
            }
            .task {
                await loadData()
            }
        }
        
        
    }
    
    func loadData() async {
        guard let url = URL(string: urlInput) else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct SendingAndReceivingCodableData_Previews: PreviewProvider {
    static var previews: some View {
        SendingAndReceivingCodableData()
    }
}
