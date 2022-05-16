//
//  CoadableData.swift
//  HotProspects
//
//  Created by Frank Chu on 5/11/22.
//

import SwiftUI

struct CoadableDataResult: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct Response: Codable {
    var results: [CoadableDataResult]
}

struct SendingAndReceivingCodableData: View {
    
    @State private var results = [CoadableDataResult]()
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
