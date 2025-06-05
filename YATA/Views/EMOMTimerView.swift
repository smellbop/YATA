//
//  EMOMTimerView.swift
//  YATA
//
//  Created by Elliot Pollard on 04/06/2025.
//

import SwiftUI

struct EMOMTimerView: View {
    // Create an instance of our speech manager
    @StateObject private var speechManager = SpeechManager()
    
    //EMOM specific
    @State private var totalRounds: Int = 3
    @State private var round: Int = 0
    @State private var roundLength: Int = 10
    @State private var roundRemaining: Int = 10
    
    //standard timer
    @State private var endDate: Date?
    @State private var timerActive = false
    @State private var timeRemaining: Int = 30
    
    
    @State private var testToggleThing = false
    
  
    func initialTimeSet()-> Int{
        return roundLength * totalRounds
    }
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    func onUpdate() {
        //only update when timer active
        guard  timerActive else { return }
        
        //update timeRemaining based on endDate
        guard let endDate else { return }
        timeRemaining = Int(endDate.timeIntervalSinceNow)
        round = totalRounds - (timeRemaining / roundLength)
        roundRemaining = timeRemaining % (roundLength)
        if (!(timeRemaining > 0)){
            self.endDate = nil
            timeRemaining = 0
            timerActive = false
        } else {
            if (timeRemaining < 4){
                playSound(soundName: "beep")
            }
        }
        voiceAnnouncement()
    }
    
//    func voiceAnnouncement(){
//        if(timeRemaining == 0){
//            sprekken("Workout Complete!")
//        }
//        if (roundRemaining == roundLength-1){
//            if (round == totalRounds){
//                sprekken("Final round.")
//            } else {
//                sprekken("Round \(round).")
//            }
//        }
//        if (totalRounds % 2 != 0 && timeRemaining == (roundLength * totalRounds)/2){
//            sprekken("Halfway there.")
//        }
//    }
    
    func voiceAnnouncement(){
        if(!testToggleThing){
            speechManager.speak(text: "HEllo, duck!")
            testToggleThing.toggle()
        }
    }
    
    func toggleTimer(){
        if (timerActive){
            //pause if started
        } else {
            //unpause if paused
            
            //start if stopped and reset (at initial time)
            endDate = Date.now + Double(timeRemaining)
        }
        timerActive.toggle()
    }
    
    func resetTimer(){
        // if started, shouldn't allow reset
        if (timerActive){
            return
        }
        // if paused/stopped
        timeRemaining = initialTimeSet()
        round = 0
        roundRemaining = roundLength
    }
    
    func remRound(){
        if totalRounds > 1 {
            totalRounds -= 1
            timeRemaining = initialTimeSet()
            roundRemaining = roundLength
        }
    }
    
    func addRound() {
        totalRounds += 1
        timeRemaining = initialTimeSet()
        roundRemaining = roundLength
    }
    
    func decRoundLength(){
        if roundLength > 60 {
            roundLength -= 60
            timeRemaining = initialTimeSet()
            roundRemaining = roundLength
        }
    }
    
    func incRoundLength(){
        roundLength += 60
        timeRemaining = initialTimeSet()
        roundRemaining = roundLength
        
    }
    
    var body: some View {
        VStack (spacing: 30) {
            VStack(spacing: 10) {
                Text("Debug info:").font(.headline)
                Text("initalTimeSet = \(initialTimeSet())")
                Text("timeRemaining = \(timeRemaining)")
                Text("timerActive = \(timerActive)")
                Text("endDate = \(endDate)")
            }
            
            
            Text("EMOM").font(.title)
            Text("Round \(round) of \(totalRounds)").font(.headline)
            Text(formatTime(roundRemaining))
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
                
                if (!timerActive && (timeRemaining != initialTimeSet())){
                    Button(action: resetTimer){
                        Text("RESET")
                    }
                }
            }
           
                if (!timerActive){
                    HStack(spacing: 30){
                        Button(action: remRound){
                            Text("-").font(.title)
                        }
                        Text("Rounds: \(totalRounds)")
                        Button(action: addRound){
                            Text("+").font(.title)
                        }
                    }
                    HStack(spacing: 30){
                        Button(action: decRoundLength){
                            Text("-").font(.title)
                        }
                        Text("Length: \(roundLength/60) min")
                        Button(action: incRoundLength){
                            Text("+").font(.title)
                        }
                    }
                }
            
        }
    }
}

#Preview {
    EMOMTimerView()
}
