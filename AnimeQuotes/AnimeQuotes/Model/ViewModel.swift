//
//  ViewModel.swift
//  AnimeQuotes
//
//  Created by Frank Chu on 6/12/22.
//

import Foundation

class ApiManager {
    enum ApiError: Error {
        case invalidURL
    }
    
    func getData<T: Codable>(url: String, model: T.Type, completion: @escaping(Result<T, Error>) -> ()) {
        guard let url = URL(string: url) else {
            completion(.failure(ApiError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let serverData = try JSONDecoder().decode(model.self, from: data)
                completion(.success(serverData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var quotes = [Quote]()
        let staticUrl = "https://animechan.vercel.app/api/quotes"
        
        var testMode: Bool
        init(testMode: Bool) {
            self.testMode = testMode
            makeApiRequest()
        }
        
        
        let apiManager = ApiManager()
        func makeApiRequest() {
            if !testMode {
                apiManager.getData(url: staticUrl, model: [Quote].self) { [weak self] result in
//                    guard let self
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let quotesByMGR):
                            self?.quotes = quotesByMGR
                        case .failure(let error):
                            let errorQuote = Quote(anime: "Error", character: "Error", quote: error.localizedDescription)
                            self?.quotes = [errorQuote]
                            print(error)
                        }
                    }
                }
//                guard let url = URL(string: staticUrl) else { return }
//
//                URLSession.shared.dataTask(with: url) { data, response, error in
//                    guard let data = data else { return }
//                    guard let decode = try? JSONDecoder().decode([Quote].self, from: data) else { return }
//
//                    DispatchQueue.main.async {
//                        self.quotes = decode
//                    }
//
//                }.resume()
                
            } else {
                self.quotes = Quote.SampleQuotes
            }
        }
    }
}
