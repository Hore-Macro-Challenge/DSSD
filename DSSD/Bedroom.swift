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
    @State private var curtainOffset: CGSize = .zero
    @State private var disablealarmBtn = true
    @State private var viewModel = StoryViewModel()
    @State private var isSwitchOn = true
    @State private var offsetyalarmBtn = 0.0
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
                    
                    ZStack{
                        Button{
                            
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
                            timeRemaining = 5
                            lampTap = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                animation -= 3
                                xOffset = 0
                                yOffset = 0
                                viewModel.moveToNextStory()
                            }
                        } label : {
                            Image(isSwitchOn ? "on_switch" : "off_switch")
                                .resizable()
                                .frame(width: size.width/40, height: size.height/25)
                        }
                        .disabled(opacity != 0.6 || alarmTap || curtainTap)
                        .position(x: size.width/2.95, y: size.height/1.7)
                        
                    }
                    VStack{
                        ZStack{
                            Image("handSign").scaleEffect(0.15).rotationEffect(Angle(degrees: 195.0)).offset(x:15, y:-70).opacity(opacityHand ? 1 : 0)
                            Image("alarmEffect").resizable().frame(width: alarmEffect ? size.width/7 : size.width/12, height: size.height/11)
                            
                            Button{
                                timeRemaining = 5
                                self.audioPlayer.stop()
                                alarmTap = false
                                opacityHand.toggle()
                                disablealarmBtn = true
                                alarmEffect = false
                                withAnimation(.linear(duration: 1)){
                                    offsetyalarmBtn = -size.width / 43
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    
                                    animation -= 4
                                    xOffset = 0
                                    yOffset = 0
                                    viewModel.moveToNextStory()
                                    
                                }
                            } label : {
                                Image("clockBtn")
                                    .resizable()
                                    .frame(width: size.width/15, height: size.height/100)
                                
                            }
                            .offset(x: 0, y: offsetyalarmBtn)
                            .disabled(disablealarmBtn)
                            
                            
                            Image("clock")
                                .resizable()
                                .frame(width: size.width/11, height: size.height/14)
                                .shadow(color: Color.white.opacity(1), radius: 20, x: 0, y: 0)
                            
                            
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
                        //                            .gesture(
                        //                                DragGesture()
                        //                                    .onChanged { value in
                        //                                        size.width/10 += value.translation.width
                        //                                    }
                        //                                    .onEnded { _ in
                        //
                        //                                    }
                        //                            )
                        Image("curtain_right")
                            .resizable()
                            .frame(width: size.width/10, height: size.height/2.35)
                            .position(x: size.width/1.12, y: (size.height - size.height/0.706))
                    }
                    .onTapGesture {
                        animation -= 0.7
                        curtainTap = false
                        xOffset = 0
                        yOffset = 0
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
                offsetyalarmBtn = -size.width / 35
            }.onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                }else{
                    if viewModel.getCurrentStory().id == 1 {
                        print(viewModel.getCurrentStory().text)
                        withAnimation(.linear(duration: 1)){
                            opacity = 0.6
                        }
                        self.audioPlayer.play()
                        withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)){
                            alarmEffect = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            if animation == 1.0 {
                                animation += 4
                                alarmTap = true
                                xOffset = Int(size.width/3)
                                yOffset = Int((size.height/2.2) * -1)
                                opacityHand.toggle()
                                disablealarmBtn = false
                            }
                            
                        }
                        
                    }
                    if viewModel.getCurrentStory().id == 2 {
                        print(viewModel.getCurrentStory().text)
                        withAnimation(.linear(duration: 1)){
                            opacity = 0.6
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            if animation == 1.0 {
                                animation += 3
                                lampTap = true
                                xOffset = Int(size.width/0.65)
                                yOffset = Int((size.height/4) * -1)
                            }
                            
                        }
                        
                    }
                    if viewModel.getCurrentStory().id == 3 {
                        print(viewModel.getCurrentStory().text)
                        withAnimation(.linear(duration: 1)){
                            opacity = 0.6
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            if animation == 1.0 {
                                animation += 0.7
                                curtainTap = true
                                xOffset = Int((size.width/2.7) * -1)
                                yOffset = Int(size.height/4.5)
                            }
                            
                        }
                        
                    }
                    
                }
            }
            ZStack(alignment: .leading){
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: size.width - (size.width/3), height: size.height - (size.height/1.12))
                    .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                    .cornerRadius(13)
                    .background(RoundedRectangle(cornerRadius: 13, style: .continuous)
                        .stroke(Color(red: 0.5, green: 0.5, blue: 0.5), lineWidth: 5))
                    .padding(.horizontal, 20)
                    .position(x: size.width/2, y: size.height/1.12)
                Image("Person")
                    .position(x: size.width/6, y: size.height/1.1)
                Text(viewModel.getCurrentStory().text)
                    .foregroundColor(.black)
                    .font(.custom("ComicSansMS-Bold", size: 20))
                    .position(x: size.width/2, y: size.height/1.12)
            }
        }.ignoresSafeArea(.all)
        
    }
}

struct Bedroom_Previews: PreviewProvider {
    static var previews: some View {
        Bedroom()
    }
}

