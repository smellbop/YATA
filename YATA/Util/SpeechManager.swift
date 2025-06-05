//
//  SpeechManager.swift
//  YATA
//
//  Created by Elliot Pollard on 05/06/2025.
//

import AVFoundation

// We'll use a simple class to manage the speech synthesizer and its delegate.
// This helps keep our view code clean.
class SpeechManager: NSObject, AVSpeechSynthesizerDelegate, ObservableObject {
    private let synthesizer = AVSpeechSynthesizer()
    
    override init() {
        super.init()
        synthesizer.delegate = self
    }
    
    func speak(text: String) {
        // 1. Configure the audio session BEFORE speaking
        setupAudioSession()
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
//        utterance.pitchMultiplier = 1.0
//        utterance.rate = AVSpeechUtterance.defaultSpeechRate
        
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
    
    // MARK: - AVSpeechSynthesizerDelegate
    
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
}


