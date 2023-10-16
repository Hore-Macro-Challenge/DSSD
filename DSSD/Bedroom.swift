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
                        }
                    }
                StoryView()
                ZStack{
                    //                    Image("light").resizable()
                    //                        .frame(width: size.width/6, height: size.height/3.1)
                    //                        .offset(x:size.width/238.8,y: size.height/18)
                    Button{
                        alarmTap.toggle()
                        if alarmTap{
                            animation += 5
                        } else {
                            animation -= 5
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
                        
                    }
                }
                .position(x: size.width/1.28, y: size.height/1.58)
            }
            .scaleEffect(alarmTap ? animation : 1, anchor: UnitPoint(x: 0.84, y: 0.65))
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

