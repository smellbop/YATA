//
//  SoundPlayer.swift
//  Athlete Timer
//
//  Created by Elliot Pollard on 28/05/2025.
//
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(soundName: String, type: String = "wav") {
    if let path = Bundle.main.path(forResource: soundName, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("ERROR: Could not find and play the sound file: \(error)")
        }
    } else {
        print("ERROR: Could not find the sound file '\(soundName).\(type)'")
    }
}
