//
//  ContentView.swift
//  ViewPlayerInSwiftUI
//
//  Created by Frank Chu on 7/21/22.
//

import AVKit
import SwiftUI

struct ContentView: View {
    @State var player = AVPlayer(url: Bundle.main.url(forResource: "四月之声", withExtension: "mp4")!)
    @State var remotePlayer = AVPlayer(url: URL(string: "https://swiftanytime-content.s3.ap-south-1.amazonaws.com/SwiftUI-Beginner/Video-Player/iMacAdvertisement.mp4")!)
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            VideoPlayer(player: player)
                .frame(width: 400, height: 280, alignment: .center)
                .padding()
                .onAppear {
//                    player.play()
                }
            VideoPlayer(player: remotePlayer) {
                VStack {
                    Text("iMac 2021 Advertisement")
                        .foregroundColor(Color.gray)
                        .bold()
                        .font(Font.title2)
                        .padding(.all, 10)
                    Spacer()
                }
            }
            .frame(width: 400, height: 300)
            .padding()
            .onAppear {
                remotePlayer.play()
                addObserver()
            }
            .onDisappear {
                removeObserver()
            }
        }
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: remotePlayer.currentItem, queue: nil) { notif in
            remotePlayer.seek(to: .zero)
            remotePlayer.play()
        }
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
