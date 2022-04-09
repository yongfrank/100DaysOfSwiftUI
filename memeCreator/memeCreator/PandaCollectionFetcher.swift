//
//  PandaCollectionFetcher.swift
//  memeCreator
//
//  Created by Frank Chu on 4/7/22.
//

import Foundation

@MainActor
class PandaCollectionFetcher: ObservableObject {
    @Published var imageData = PandaCollection(sample: [Panda.defaultPanda])
    @Published var currentPanda = Panda.defaultPanda
    
    let urlString = "http://playgrounds-cdn.apple.com/assets/pandaData.json"
    
    enum FetchError: Error {
        case badRequst, badJSON
    }
    
    @available(iOS 15.0, *)
    func fetchData() async
    throws {
        guard let url = URL(string: urlString) else { return }
        
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badRequst }
        
        imageData = try JSONDecoder().decode(PandaCollection.self, from: data)
    }
}
