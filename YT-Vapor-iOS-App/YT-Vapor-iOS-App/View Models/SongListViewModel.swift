//
//  SongListViewModel.swift
//  YT-Vapor-iOS-App
//
//  Created by Frank Chu on 7/14/22.
//

import Foundation

class SongListViewModel: ObservableObject {
    @Published var songs = [Song]()
    
    func fetchSongs() async throws {
        let urlstring = Constants.baseURL + Endpoints.songs
        
        guard let url = URL(string: urlstring) else {
            throw HttpError.badURL
        }
        
        let songResponse: [Song] = try await HttpClient.shared.fetch(url: url)
        
        DispatchQueue.main.async {
            self.songs = songResponse
        }
        
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { i in
            guard let songID = songs[i].id else {
                return
            }
            
            guard let url = URL(string: Constants.baseURL + Endpoints.songs + "/\(songID)") else {
                return
            }
            
            Task {
                do {
                    try await HttpClient.shared.delete(at: songID, url: url)
                } catch {
                    print("DEBUG: 👁 delete error in SongListVM \(error.localizedDescription) \(error)")
                }
            }
        }
        
        songs.remove(atOffsets: offsets)
    }
}
