//
//  recapView.swift
//  DSSD
//
//  Created by Cliffton S on 18/10/23.
//

import SwiftUI

struct recapView: View {
    @State var scaleEff = 0.7
    @State var isAnimate = 0.0
    @Binding var show: Bool
    var body: some View {
        ZStack{
            if show {
                Color.black.opacity(show ? 0.6 : 0).edgesIgnoringSafeArea(.all)
                        
                ZStack{
                    Image("scenewin").resizable().frame(width: 310,height: 480).opacity(isAnimate)
                    HStack{
                        
                        Image("starfill").scaleEffect(scaleEff).opacity(isAnimate)
                        Image("starfill").resizable().frame(width: 80, height: 80).offset(y: -10).scaleEffect(scaleEff).opacity(isAnimate)
                        Image("starfill").scaleEffect(scaleEff).opacity(isAnimate)
                        
                    }.offset(y: -45)
                }.scaleEffect(1.3).offset(y: -90)
            }
            
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    scaleEff = 1.0
                    isAnimate = 1.0
                }
            }
        }
    }
}

#Preview {
    recapView(show: .constant(true))
}
