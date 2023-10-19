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
    let timerShake = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    @State private var timeRemaining: Double = 5
    @State private var timeShake: Double = 5
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
    @State private var curtainleftDrag = 0.0
    @State private var curtainrightDrag = 0.0
    @State private var cekcurtain = 0
    @State private var done = false
    @State private var showRecap = false
    @State private var shake = false
    @State private var clock = false
    
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
                        .frame(width: size.width/2.2, height: size.height/2)
                        .position(x: size.width/2.11, y: size.height/1.64)
                    Rectangle().opacity(opacity)
                    
                    ZStack{
                        Button{
                            
                        } label : {
                            Image(isSwitchOn ? "lamp_on" : "lamp_off")
                                .resizable()
                                .frame(width: size.width/7, height: size.height/3)
                                .shadow(color: Color.white.opacity(1), radius: 20, x: 0, y: 0)
                        }
                        .disabled(viewModel.getCurrentStory().id != 2 || lampTap != true)
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
                        .disabled(viewModel.getCurrentStory().id != 2 || lampTap != true)
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
                            
                            Button {
                                    clock = true
                            } label : {
                                Image("clock")
                                    .resizable()
                                    .frame(width: size.width/11, height: size.height/14)
                                    .shadow(color: Color.white.opacity(1), radius: 20, x: 0, y: 0)
                            }.onReceive(timerShake) { _ in
                                if clock == true && timeShake > 0 {
                                    timeShake -= 1
                                    shake.toggle()
                                } else {
                                    timeShake = 5
                                    clock = false
                                }
                            }
                            
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
                            .position(x: size.width/1.196, y: (size.height - size.height/0.9))
                        Image(curtainleftDrag == -60 ? "curtain_left_open" : "curtain_left")
                            .resizable()
                            .frame(width: curtainleftDrag == -60 ? size.width/12 : size.width/10 + curtainleftDrag, height: size.height/2.35)
                            .position(x: curtainleftDrag == -60 ? size.width/1.32 : size.width/1.29 + curtainleftDrag/2, y: (size.height - size.height/0.86))
                            .gesture(curtainleftDrag != -60 || viewModel.getCurrentStory().id == 3 ? DragGesture()
                                .onChanged { value in
                                    if value.translation.width < 0 {
                                        let newDragValue =  value.translation.width
                                        curtainleftDrag = max(-60, newDragValue)
                                    }
                                }
                                .onEnded { _ in
                                    curtainleftDrag = curtainleftDrag
                                    if curtainleftDrag == -60{
                                        cekcurtain += 1
                                    }
                                } : nil
                            )
                        Image(curtainrightDrag == 60 ? "curtain_right_open" : "curtain_right")
                            .resizable()
                            .frame(width: curtainrightDrag == 60 ? size.width/12 : size.width/10 - curtainrightDrag, height: size.height/2.35)
                            .position(x: curtainrightDrag == 60 ? size.width/1.10  : size.width/1.12 + curtainrightDrag/2, y: (size.height - size.height/0.706))
                            .gesture(curtainrightDrag != 60 || viewModel.getCurrentStory().id == 3 ? DragGesture()
                                .onChanged { value in
                                    if value.translation.width > 0 {
                                        let newDragValue =  value.translation.width
                                        curtainrightDrag =  min(60, newDragValue)
                                    }
                                }
                                .onEnded { _ in
                                    // Reset posisi saat gesture selesai
                                    curtainrightDrag = curtainrightDrag
                                    if curtainrightDrag == 60{
                                        cekcurtain += 1
                                        print(cekcurtain)
                                    }
                                } : nil
                            )
                        
                    }.onChange(of: cekcurtain) { newValue in
                        if newValue == 2{
                            timeRemaining = 5
                            done = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                animation -= 0.7
                                curtainTap = false
                                xOffset = 0
                                yOffset = 0
                            }
                        }
                    }
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
                }else if timeRemaining == 0{
                    if viewModel.getCurrentStory().id == 1 {
                        print(viewModel.getCurrentStory().text)
                        withAnimation(.linear(duration: 1)){
                            opacity = 0.6
                        }
                        
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
                    if viewModel.getCurrentStory().id == 3 && done != true{
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
                    if viewModel.getCurrentStory().id == 3 && done == true{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            showRecap = true
                        }
                        
                    }
                    timeRemaining -= 1
                    
                }else{
                    if viewModel.getCurrentStory().id == 1{
                        self.audioPlayer.play()
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
                Image("boy")
                    .position(x: size.width/6, y: size.height/1.5)
                        .scaleEffect(x: shake ? -1 : 1, y: 1, anchor: .center)
                        .offset(x: shake ? -size.width/1.52 : 0, y: 0)
                Image("body")
                    .position(x: size.width/5.8, y: size.height/0.995)
                Text(viewModel.getCurrentStory().text)
                    .foregroundColor(.black)
                    .font(.custom("ComicSansMS-Bold", size: 20))
                    .position(x: size.width/2, y: size.height/1.12)
            }
            
            recapView(show: $showRecap)
        }.ignoresSafeArea(.all)
        
    }
}

struct Bedroom_Previews: PreviewProvider {
    static var previews: some View {
        Bedroom()
    }
}

