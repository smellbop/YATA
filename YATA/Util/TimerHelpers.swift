//
//  TimerHelpers.swift
//  Athlete Timer
//
//  Created by Elliot Pollard on 28/05/2025.
//

//import Foundation

enum TimerType: String, CaseIterable, Identifiable {
    case standard = "Standard"
    case emom = "EMOM"
    case interval = "Interval"
    var id: String { self.rawValue }
}

func formatTime(_ totalSeconds: Int) -> String {
    let minutes = totalSeconds / 60
    let seconds = totalSeconds % 60
    return String(format: "%02d:%02d", minutes, seconds)
}
