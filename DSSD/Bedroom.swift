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
    @State private var xOffset = 0
    @State private var yOffset = 0
    @State private var alarmTap = false
    @State private var lampTap = false
    @State private var curtainTap = false
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ZStack{
                ZStack{
                    Image("bedroom")
                        .resizable()
                    //                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                    Rectangle().opacity(opacity)
                        .onReceive(timer) { _ in
                            timeRemaining -= 1
                            if timeRemaining <= 1 {
                                timeRemaining = 0
                                opacity = 0.6
                            }
                        }
                    VStack{
                        Button{
                            if animation == 1.0 {
                                animation += 3
                                lampTap = true
                                xOffset = Int(size.width/1.1)
                                yOffset = Int(size.height/1.85)
                            } else {
                                animation -= 3
                                lampTap = false
                                xOffset = 0
                                yOffset = 0
                            }
                        } label : {
                            Image("lamp_on")
                                .resizable()
                                .frame(width: size.width/7, height: size.height/3)
                                .shadow(color: Color.white.opacity(1), radius: 20, x: 0, y: 0)
                            
                        }
                        .disabled(opacity != 0.6 || alarmTap || curtainTap)
                    }
                    .position(x: size.width/3.7, y: size.height/2.8)
                    VStack{
                        Button{
                            if animation == 1.0 {
                                animation += 4
                                alarmTap = true
                                xOffset = Int((size.width/2) * -1)
                                yOffset = Int(size.height/2)
                            } else {
                                animation -= 4
                                alarmTap = false
                                xOffset = 0
                                yOffset = 0
                            }
                        } label : {
                            Image("clock")
                                .resizable()
                                .frame(width: size.width/10, height: size.height/10)
                                .shadow(color: Color.white.opacity(1), radius: 20, x: 0, y: 0)
                        }
                        .disabled(opacity != 0.6 || lampTap || curtainTap)
                    }
                    .position(x: size.width/1.66, y: size.height/2.5)
                    VStack{
                        Image("window")
                            .resizable()
                            .frame(width: size.width/4.3, height: size.height/3.5)
                            .shadow(color: Color.white.opacity(1), radius: 20, x: 0, y: 0)
                            .position(x: size.width/1.2, y: size.height/3.2)
                        Image("trail")
                            .resizable()
                            .frame(width: size.width/4, height: (size.height - size.height/1.03))
                            .position(x: size.width/1.19, y: (size.height - size.height/0.91))
                        Image("curtain_left")
                            .resizable()
                            .frame(width: size.width/10, height: size.height/2.35)
                            .position(x: size.width/1.29, y: (size.height - size.height/0.86))
                        Image("curtain_right")
                            .resizable()
                            .frame(width: size.width/10, height: size.height/2.35)
                            .position(x: size.width/1.12, y: (size.height - size.height/0.706))
                    }
                    .onTapGesture {
                        if animation == 1.0 {
                            animation += 0.7
                            curtainTap = true
                            xOffset = Int((size.width/2) * -1)
                            yOffset = Int(size.height/4.5)
                        } else {
                            animation -= 0.7
                            curtainTap = false
                            xOffset = 0
                            yOffset = 0
                        }
                    }
                    .disabled(opacity != 0.6 || lampTap || alarmTap)
                }
                .scaleEffect(animation)
                .offset(x: CGFloat(xOffset), y: CGFloat(yOffset))
                .animation(
                    .easeInOut(duration: 1.5),
                    value: animation)
            }
            
            StoryView()
        }.ignoresSafeArea()
    }
}

struct Bedroom_Previews: PreviewProvider {
    static var previews: some View {
        Bedroom()
    }
}

