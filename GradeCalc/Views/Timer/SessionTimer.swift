//
//  SessionTimer.swift
//  GradeCalc
//
//  Created by Marwah Ameen on 09/07/1444 AH.
//  Copyright © 1444 AH Marlon Lückert. All rights reserved.
//  Created by Farukh IQBAL on 07/04/2020.
//  Copyright © 2020 Farukh IQBAL. All rights reserved.
//

import SwiftUI


struct SessionTimer: View {
    
    @ObservedObject var timerManager = TimerManager()
    
    @State var selectedPickerIndex = 0
    
    let availableMinutes = Array(1...59)
    
    var body: some View {
        
        NavigationView {
            VStack {
                if #available(iOS 15.0, *) {
                    Text(secondsToMinutesAndSeconds(seconds: timerManager.secondsLeft))
                        .font(.system(size: 80))
                        .padding(.top, 80)
                        .foregroundStyle(
                            gradient())
                } else {
                    // Fallback on earlier versions
                }
                ZStack {
                    gradient()
                    .mask(Image(systemName: timerManager.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
                      .resizable()
                      .aspectRatio(contentMode: .fit))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
                   
                    .onTapGesture(perform: {
                        if self.timerManager.timerMode == .initial {
                            self.timerManager.setTimerLength(minutes: self.availableMinutes[self.selectedPickerIndex]*60)
                        }
                        self.timerManager.timerMode == .running ? self.timerManager.pause() : self.timerManager.start()
                    })
                }.cornerRadius(15)
                if timerManager.timerMode == .paused {
                    Image(systemName: "gobackward")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .padding(.top, 40)
                    .onTapGesture(perform: {
                        self.timerManager.reset()
                    })
                }
                if timerManager.timerMode == .initial {
                    Picker(selection: $selectedPickerIndex, label: Text("")) {
                        ForEach(0 ..< availableMinutes.count) {
                            Text("\(self.availableMinutes[$0]) min")
                        }
                    }
                    .labelsHidden()
                }
                Spacer()
            }
            //.navigationBarTitle("Timer")
            .padding(.top, 100)
            
        
            
        }
        //.environment(\.colorScheme, .dark)
        
        .alert(isPresented: $timerManager.showAlert)
        {
            Alert(
                title: Text("Session Completed"),
                message: Text("🤩 Good Job! 🥳"),
                dismissButton: .default(Text("Okay"))
            )
        }
    }
}

struct SessionTimer_Previews: PreviewProvider {
    static var previews: some View {
        SessionTimer()
    }
}

