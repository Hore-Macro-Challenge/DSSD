//
//  storybedroomView.swift
//  DSSD
//
//  Created by Cliffton S on 15/10/23.
//

import SwiftUI

struct storybedroomView: View {
    @State private var degrees = 0.0
    var body: some View {
        GeometryReader{proxy in
            let size = proxy.size
            ZStack{
                Image("bedroom").resizable().aspectRatio(contentMode: .fill).frame(width: size.width, height: size.height)
                Rectangle().opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                ZStack{
                    Image("light").resizable()
                        .frame(width: size.width/6, height: size.height/3.1)
                        .offset(x:size.width/238.8,y: size.height/18)
                        .rotationEffect(Angle.degrees(degrees))
                        .onAppear{
                            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                                self.degrees += 300
                            }
                        }
                    Image("clock").resizable().frame(width: size.width/10, height: size.height/10)
                    
                        
                }.position(x: size.width/1.28, y: size.height/1.58)
            }
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    storybedroomView()
}
