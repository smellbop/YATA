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
    setupAudioSession()
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

private func setupAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            // The .playback category is for playing audio, and .duckOthers lowers the volume
            // of other audio sessions instead of stopping them.
            try session.setCategory(.playback, mode: .default, options: .duckOthers)
            try session.setActive(true)
        } catch {
            print("❌ ERROR: Failed to set up audio session: \(error.localizedDescription)")
        }
    }

func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        // 2. Deactivate the audio session AFTER speaking to allow other apps to resume fully.
        // This is good practice.
        deactivateAudioSession()
    }

private func deactivateAudioSession() {
        do {
            // Using .notifyOthersOnDeactivation allows the other app (e.g., Music)
            // to be notified that your app is done with audio.
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            print("❌ ERROR: Failed to deactivate audio session: \(error.localizedDescription)")
        }
    }
