//
//  ContentView.swift
//  YATA
//
//  Created by Elliot Pollard on 03/06/2025.
//

import SwiftUI
import Foundation

struct StandardTimerView: View {
    @State private var endDate: Date?
    @State private var initialTimeSet: Int = 600
    @State private var timerActive = false
    @State private var timeRemaining: Int = 600
   // @State private var speakingCountDown: Int = 0 // a bit of a hack until I RTFM
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
    func onUpdate() {
//        if (speakingCountDown > 0){
//            speakingCountDown -= 1
//        }
        //only update when timer active
        guard  timerActive else { return }
        
        //update timeRemaining based on endDate
        guard let endDate else { return }
        timeRemaining = Int(endDate.timeIntervalSinceNow)
                
        if (!(timeRemaining > 0)){
            self.endDate = nil
            timeRemaining = 0
            timerActive = false
            sprekken("Workout Complete!")
        } else {
            if (//speakingCountDown == 0 &&
                timeRemaining == initialTimeSet/2){
                //speakingCountDown = 1
                sprekken("Halfway there!")
            }
            if (timeRemaining < 4){
                playSound(soundName: "beep")
            }
        }
    }
    
    func toggleTimer(){
        if (timerActive){
            //pause if started
        } else {
            //unpause if paused
            
            //start if stopped and reset (at initial time)
            endDate = Date.now + Double(timeRemaining + 1)
            sprekken("\(timeRemaining/60) minutes.")
        }
        timerActive.toggle()
    }
    
    func resetTimer(){
        // if started
        if (timerActive){
            endDate = Date.now + Double(initialTimeSet + 1)
        } else {
            // if paused/stopped
            timeRemaining = initialTimeSet
        }
    }
    
    func addTime(_ amount: Int){
        if (amount + timeRemaining) < 0 {
            return
        }
        if (timerActive){
            endDate = Date.now + Double(amount + 1 + timeRemaining)
        } else {
            if (initialTimeSet == timeRemaining){
                initialTimeSet += amount
                timeRemaining += amount
            } else {
                timeRemaining += amount
            }
        }
    }
    
    var body: some View {
        VStack (spacing: 30) {
            VStack(spacing: 10) {
                Text("Debug info:").font(.headline)
                Text("initalTimeSet = \(initialTimeSet)")
                Text("timeRemaining = \(timeRemaining)")
                Text("timerActive = \(timerActive)")
                Text("endDate = \(endDate)")
            }
            //Main Clock
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
    StandardTimerView()
}
