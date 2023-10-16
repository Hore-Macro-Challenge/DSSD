//
//  menuView.swift
//  DSSD
//
//  Created by Cliffton S on 13/10/23.
//

import SwiftUI

struct selectView: View {
    @State private var select = "boy"
    @State private var degrees = 0.0
    @State private var start = false
    @State private var scale = 0.0
    @AppStorage("character") var character: String = ""
    var body: some View {
        if start {
            gameplayView()
        }
        else {
            GeometryReader{proxy in
                let size = proxy.size
                ZStack{
                    Image("backgroundSample2").resizable().aspectRatio(contentMode: .fill).frame(width: size.width, height: size.height)
                    VStack{
                        Spacer()
                        Spacer()
                        HStack{
                            Spacer()
                            Spacer()
                            ZStack{
                                if select == "boy"{
                                    Image("light")
                                        .resizable()
                                        .frame(width: size.width/4.78, height: size.height/2.78, alignment: .center)
                                        .clipped()
                                        .offset(x:0, y:size.height/23.8)
                                        .scaleEffect(1.7)
                                }
                                Button{
                                    select = "boy"
                                } label : {
                                    Image("characterBoy")
                                        .resizable()
                                        .frame(width: size.width/6, height: size.height/2.38)
                                        .scaleEffect(select == "boy" ? 1.3 : 1)
                                    
                                }
                                
                            }
                            Spacer()
                            ZStack{
                                if select == "girl"{
                                    Image("light")
                                        .resizable()
                                        .frame(width: size.width/4.78, height: size.height/2.78, alignment: .center)
                                        .clipped()
                                        .offset(x:0, y:size.height/23.8)
                                        .scaleEffect(1.7)
                                }
                                Button{
                                    select = "girl"
                                } label : {
                                    Image("characterGirl")
                                        .resizable()
                                        .frame(width: size.width/6, height: size.height/2.38)
                                        .scaleEffect(select == "girl" ? 1.3 : 1)
                                }
                            }
                            Spacer()
                            Spacer()
                        }
                        Spacer()
                        Button{
                            character = select
                            start = true
                            
                        } label : {
                            Image("selectBtn")
                                .resizable()
                                .frame(width: size.width / 5, height: size.height / 6)
                        }
                        Spacer()
                        Spacer()
                    }
                }
                
            }.ignoresSafeArea(.all)
        }
    }
}

#Preview {
    selectView()
}
