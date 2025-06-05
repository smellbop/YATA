//
//  SoundPlayer.swift
//  Athlete Timer
//
//  Created by Elliot Pollard on 28/05/2025.
//
import AVFoundation

var audioPlayer: AVAudioPlayer?

// Retrieve the British English voice.
let voice = AVSpeechSynthesisVoice(language: "en-IE")
// Create a speech synthesizer.
let synthesizer = AVSpeechSynthesizer()

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

func sprekken(_ speech: String){
    if (synthesizer.isSpeaking){
        return
    }
    // Create an utterance.
    let utterance = AVSpeechUtterance(string: "\(speech)")


//    // Configure the utterance.
//    utterance.rate = 0.57
//    utterance.pitchMultiplier = 0.8
//    utterance.postUtteranceDelay = 0.2
//    utterance.volume = 0.8

    // Assign the voice to the utterance.
    utterance.voice = voice

    // Tell the synthesizer to speak the utterance.
    synthesizer.speak(utterance)

}
