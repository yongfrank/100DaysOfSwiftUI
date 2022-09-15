//
//  ContentView.swift
//  SoundTest
//
//  Created by Frank Chu on 9/3/22.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    let leftUtterance = AVSpeechUtterance(string: "正在向左偏")
    var body: some View {
        VStack {
            Button("Play") {
                self.playSound(utterance: self.leftUtterance)
            }
        }
        .padding()
    }
    
    func playSound(utterance: AVSpeechUtterance) {
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-cn")
        AVSpeechSynthesizer().speak(utterance)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
