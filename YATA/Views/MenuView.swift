//
//  MenuView.swift
//  YATA
//
//  Created by Elliot Pollard on 04/06/2025.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: StandardTimerView()) {
                    Text("Standard Timer")
                        .font(.title)
                        .foregroundStyle(.white)
                }
                .listRowBackground(Color.blue)

                NavigationLink(destination: IntervalTimerView()) {
                    Text("Interval Timer")
                        .font(.title)
                        .foregroundStyle(.white)
                }
                .listRowBackground(Color.green)

                NavigationLink(destination: EMOMTimerView()) {
                    Text("EMOM Timer")
                        .font(.title)
                        .foregroundStyle(.white)
                }
                .listRowBackground(Color.red)
            }
            .navigationTitle("YATA")
        }

    }
}

#Preview {
    MenuView()
}
