//
//  ContentView.swift
//  YATA
//
//  Created by Elliot Pollard on 03/06/2025.
//

import SwiftUI
import Foundation

struct StandardTimer: View {
    @State private var initialTimeSet = 600
    @State private var timeRemaining = 600
    @State private var timerActive = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func toggleTimer() {
        timerActive.toggle()
    }
    
    func resetTimer() {
        timeRemaining = initialTimeSet
    }
    
    func addTime(_ amount:Int){
        timeRemaining += amount
        if (!timerActive && timeRemaining == initialTimeSet + amount){
            initialTimeSet = timeRemaining
        }
    }

    fileprivate func onUpdate() {
        guard timerActive else { return }
        if timeRemaining > 0 {
            timeRemaining -= 1
            if timeRemaining < 5 {
                playSound(soundName: "beep")
            }
        } else {
            timerActive.toggle()
        }
        
        
    }
    
    var body: some View {
        VStack (spacing: 30) {
            VStack(spacing: 10) {
                Text("initalTimeSet = \(initialTimeSet)")
                Text("timeRemaining = \(timeRemaining)")
                Text("timerActive = \(timerActive)")
            }
            Text(formatTime(timeRemaining))
                .font(.system(size: 70, design: .monospaced))
                .onReceive(timer) { _ in
                    onUpdate()
                    }
            
            HStack(spacing: 30) {
                Button(action: toggleTimer){
                    Text(timerActive ? "PAUSE" : "START")
                }
                
                Button(action: resetTimer){
                    Text("RESET")
                }
            }
            

            
            HStack(spacing: 30) {
                Button(action: {addTime(10)}){
                    Text("+10 seconds")
                }
                
                Button(action: {addTime(-10)}){
                    Text("-10 seconds")
                }
            }

            
            HStack(spacing: 30) {
                Button(action: {addTime(30)}){
                    Text("+30 seconds")
                }
                
                Button(action: {addTime(-30)}){
                    Text("-30 seconds")
                }
            }
 
            
            HStack(spacing: 30){
                Button(action: {addTime(60)}){
                    Text("+1 minute")
                }
                Button(action: {addTime(-60)}){
                    Text("-1 minute")
                }
            }
            
        }
      
    }
}

#Preview {
    StandardTimer()
}
