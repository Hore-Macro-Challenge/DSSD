//
//  Bedroom.swift
//  DSSD
//
//  Created by Aiffah Kiysa Waafi on 13/10/23.
//

import SwiftUI
import AVFoundation

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
    @State private var position: CGSize = .zero
    @GestureState private var translation: CGSize = .zero
    @State private var alarmEffect = false
    @State var audioPlayer: AVAudioPlayer!
    @State private var opacityHand = false
    @State private var isSwitchOn = true
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ZStack{
                ZStack{
                    Image("bedroom")
                        .resizable()
                    //                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width*1.5, height: size.height)
                    Image("bed")
                        .resizable()
                        .frame(width: size.width/0.95, height: size.height/1)
                        .position(x: size.width/2, y: size.height/1.8)
                    Rectangle().opacity(opacity)
                        .onReceive(timer) { _ in
                            timeRemaining -= 1
                            if timeRemaining <= 1 {
                                timeRemaining = 0
                                opacity = 0.6
                                //                                self.audioPlayer.play()
                                withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)){
                                    alarmEffect = true
                                }
                                
                            }
                        }
                    VStack{
                        Button{
                            if animation == 1.0 {
                                animation += 3
                                lampTap = true
                                xOffset = Int(size.width/0.65)
                                yOffset = Int((size.height/4) * -1)
                            } else {
                                animation -= 3
                                lampTap = false
                                xOffset = 0
                                yOffset = 0
                            }
                        } label : {
                            Image(isSwitchOn ? "lamp_on" : "lamp_off")
                                .resizable()
                                .frame(width: size.width/7, height: size.height/3)
                                .shadow(color: Color.white.opacity(1), radius: 20, x: 0, y: 0)
                        }
                        .disabled(opacity != 0.6 || alarmTap || curtainTap)
                        .position(x: size.width/3.5, y: size.height/1.82)
                        Button{
                            isSwitchOn.toggle()
                        } label : {
                            Image(isSwitchOn ? "on_switch" : "off_switch")
                                .resizable()
                                .frame(width: size.width/40, height: size.height/25)
                        }
                        .disabled(opacity != 0.6 || alarmTap || curtainTap)
                        .position(x: size.width/2.95, y: size.height/12)
                        
                    }
                    VStack{
                        ZStack{
                            Image("handSign").scaleEffect(0.15).rotationEffect(Angle(degrees: 195.0)).offset(x:15, y:-65).opacity(opacityHand ? 1 : 0)
                            Image("alarmEffect").resizable().frame(width: alarmEffect ? size.width/7 : size.width/12, height: size.height/11)
                            
                            Button{
                                if animation == 1.0 {
                                    animation += 4
                                    alarmTap = true
                                    xOffset = Int(size.width/3)
                                    yOffset = Int((size.height/2.2) * -1)
                                    opacityHand.toggle()
                                } else {
                                    animation -= 4
                                    alarmTap = false
                                    xOffset = 0
                                    yOffset = 0
                                    opacityHand.toggle()
                                }
                            } label : {
                                Image("clock")
                                    .resizable()
                                    .frame(width: size.width/11, height: size.height/11)
                                    .shadow(color: Color.white.opacity(1), radius: 20, x: 0, y: 0)
                            }
                            .disabled(opacity != 0.6 || lampTap || curtainTap)
                            
                            
                        }
                    }
                    .position(x: size.width/1.57, y: size.height/1.68)
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
                            xOffset = Int((size.width/2.7) * -1)
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
            }.onAppear{
                let sound = Bundle.main.path(forResource: "alarm", ofType: "mp3")
                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
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

