//
//  SongList.swift
//  YT-Vapor-iOS-App
//
//  Created by Frank Chu on 7/14/22.
//

import SwiftUI

struct SongList: View {
    @StateObject var viewModel = SongListViewModel()
    
    @State private var modal: ModalType? = nil
    
    var body: some View {
        NavigationStack {
            Text(Date.now.formatted(date: .omitted, time: .standard))

            List {
                ProgressView()
                ForEach(viewModel.songs) { song in
                    Button {
//                        print("selected \(song.title)")
                        modal = .update(song)
                    } label: {
                        Text("\(song.title)")
                            .font(.title3)
                            .foregroundColor(Color(.label))
                    }
                }
                .onDelete(perform: viewModel.delete)
            }
            .navigationTitle("🎵 Songs")
            .toolbar {
                Button {
                    modal = .add
                } label: {
                    Label("Add Song", systemImage: "plus.circle")
                }
            }
            .refreshable {
                Task {
                    do {
                        try await viewModel.fetchSongs()
                    } catch {
                        print("DEBUT: 🫠 error in refreshable \(error.localizedDescription) \(error)")
                    }
                }
            }
        }
        .sheet(item: $modal, onDismiss: {
            Task {
                do {
                    try await viewModel.fetchSongs()
                } catch {
                    print("❌ Error: \(error) ❌ \(error.localizedDescription)")
                }
            }
        }, content: { modal in
            switch modal {
            case .add:
                AddUpdateSong(viewModel: AddUpdateSongViewModel())
            case .update(let song):
                AddUpdateSong(viewModel: AddUpdateSongViewModel(currentSong: song))
            }
        })
        .onAppear {
            Task {
                do {
                    try await viewModel.fetchSongs()
                } catch {
                    print("\n\n ❌ Error: \(error) \(error.localizedDescription)")
                }
            }
        }
    }
}

struct SongList_Previews: PreviewProvider {
    static var previews: some View {
        SongList()
    }
}
