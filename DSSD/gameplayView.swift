//
//  gameplayView.swift
//  DSSD
//
//  Created by Cliffton S on 15/10/23.
//

import SwiftUI

struct gameplayView: View {
    @State private var gameplay = ""
    @State var endStory = false
    var body: some View {
        if gameplay == "story"{
            Bedroom()
        } else if gameplay == "freeplay"{
            
        } else {
            GeometryReader{proxy in
                let size = proxy.size
                ZStack{
                    Image("backgroundSample2").resizable().aspectRatio(contentMode: .fill).frame(width: size.width, height: size.height)
                    VStack{
                        Button{
                            gameplay = "story"
                        } label : {
                            Image("storyBtn")
                                .resizable()
                                .frame(width: size.width / 5, height: size.height / 6)
                        }
                        Button{
                            gameplay = "freeplay"
                        } label : {
                            Image("freeplayBtn")
                                .resizable()
                                .frame(width: size.width / 5, height: size.height / 6)
                        }
                    }
                }
            }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}

//#Preview {
//    gameplayView()
//}
