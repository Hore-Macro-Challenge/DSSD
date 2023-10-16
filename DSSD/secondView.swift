//
//  secondView.swift
//  DSSD
//
//  Created by Cliffton S on 15/10/23.
//

import SwiftUI

struct secondView: View {
    @State private var menu = ""
    var body: some View {
        if menu == "play" {
            gameplayView()
        } else if menu == "character"{
            selectView()
        }
        else {
            GeometryReader{proxy in
                let size = proxy.size
                ZStack{
                    Image("backgroundSample2").resizable().aspectRatio(contentMode: .fill).frame(width: size.width, height: size.height)
                    VStack{
                        Button{
                            menu = "play"
                        } label : {
                            Image("playBtn2")
                                .resizable()
                                .frame(width: size.width / 5, height: size.height / 6)
                        }
                        Button{
                            menu = "character"
                        } label : {
                            Image("characterBtn")
                                .resizable()
                                .frame(width: size.width / 5, height: size.height / 7)
                        }
                    }
                }
            }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}

//#Preview {
//    secondView()
//}
