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
    @State private var initialTimeSet = 5
    @State private var timeRemaining = 5
    @State private var timerActive = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
    func onUpdate() {
        //do nothing
    }
    
    func toggleTimer(){
        if (timerActive){
            //pause
        }
        timerActive.toggle()
    }
    func resetTimer(){}
    func addTime(_ amount: Int){}
    
    var body: some View {
        VStack (spacing: 30) {
            VStack(spacing: 10) {
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
