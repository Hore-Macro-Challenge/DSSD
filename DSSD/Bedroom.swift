//
//  Bedroom.swift
//  DSSD
//
//  Created by Aiffah Kiysa Waafi on 13/10/23.
//

import SwiftUI

struct Bedroom: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timeRemaining: Double = 5
    @State private var opacity = 0.0
    @State private var animation = 1.0
    @State private var anchorPoint = UnitPoint(x: 0, y: 0)
    @State private var alarmTap = false
    @State private var tap = ""
    @StateObject private var viewModel = StoryViewModel()
    @State private var disableBtn = true
    let focusPoint = CGPoint(x: 100, y: 100)
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ZStack{
                Image("bedroom")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                
                
                Rectangle().opacity(opacity)
                    .onReceive(timer) { _ in
                        timeRemaining -= 1
                        if timeRemaining <= 1 {
                            timeRemaining = 0
                            opacity = 0.6
                            disableBtn = false
                        }
                    }
                StoryView()
                ZStack{
                    //                    Image("light").resizable()
                    //                        .frame(width: size.width/6, height: size.height/3.1)
                    //                        .offset(x:size.width/238.8,y: size.height/18)
                    Button{
                        if viewModel.currentIndex == 0 {
                            if tap == ""{
                                animation += 5
                                tap = "alarm"
                                disableBtn = true
                            }
                        } else {
                            
                        }
//                        anchorPoint = UnitPoint(x: 0.84, y: 0.65)
                    } label : {
                        Image("clock")
                            .resizable()
                            .frame(width: size.width/10, height: size.height/10)
                            .shadow(color: Color.white.opacity(1), radius: 20, x: 0, y: 0)
//                            .scaleEffect(animation, anchor: .trailing)
//                            .animation(
//                                .easeInOut(duration: 1.5),
//                                value: animation)
                        
                    }.disabled(disableBtn)
                }
                .position(x: size.width/1.28, y: size.height/1.58)
            }
            .scaleEffect(tap == "alarm" ? animation : (tap == "lamp" ? animation : (tap == "curtain" ? animation : 1)))
            .offset(x: tap == "alarm" ? -2000 : (tap == "lamp" ? -2000 : (tap == "curtain" ? -2000 : 0)), y: tap == "alarm" ? -650 : (tap == "lamp" ? -650 : (tap == "curtain" ? -650 : 0)))
            .animation(
                .easeInOut(duration: 1.5),
                value: animation)
        }.ignoresSafeArea()
    }
}

struct Bedroom_Previews: PreviewProvider {
    static var previews: some View {
        Bedroom()
    }
}

