//
//  AddUpdateSongViewModel.swift
//  YT-Vapor-iOS-App
//
//  Created by Frank Chu on 7/14/22.
//

import Foundation

final class AddUpdateSongViewModel: ObservableObject {
    @Published var songTitle = ""
    
    var songID: UUID?
    
    var isUpdating: Bool {
        songID != nil
    }
    
    var buttonTitle: String {
        songID != nil ? "Update Song" : "Add Song"
    }
    
    init() { }
    
    init(currentSong: Song) {
        self.songID = currentSong.id
        self.songTitle = currentSong.title
    }
    
    func addSong() async throws {
        let urlstring = Constants.baseURL + Endpoints.songs
        
        guard let url = URL(string: urlstring) else {
            throw HttpError.badURL
        }
        
        let song = Song(id: nil, title: songTitle)
        
        try await HttpClient.shared.sendData(to: url, object: song, httpMethod: HttpMethods.POST.rawValue)
    }
    
    func updateSong() async throws {
        let urlString = Constants.baseURL + Endpoints.songs
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let songToUpdate = Song(id: songID, title: songTitle)
        try await HttpClient.shared.sendData(to: url, object: songToUpdate, httpMethod: HttpMethods.PUT.rawValue)
    }
    
    /// This is for update
    /// Parameter: Nothing
    /// Output: Noting
    func addUpdateAction(completion: @escaping () -> Void) {
        Task {
            do {
                if isUpdating {
                    try await updateSong()
                } else {
                    try await addSong()
                }
            } catch {
                print("❌ \(error) ❌ \(error.localizedDescription)")
            }
            completion()
        }
    }
}
