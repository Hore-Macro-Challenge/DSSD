//
//  startPage.swift
//  DSSD
//
//  Created by Cliffton S on 13/10/23.
//

import SwiftUI

struct firstView: View {
    @State private var play = false
    var body: some View {
        if play {
            selectView()
        }
        else {
            GeometryReader{proxy in
                let size = proxy.size
                ZStack{
                    Image("backgroundSample").resizable().aspectRatio(contentMode: .fill).frame(width: size.width, height: size.height)
                    Image("logo")
                        .resizable()
                        .frame(width: size.width / 3, height: size.height / 4)
                        .position(x: size.width / 2, y: size.height / 3)
                    Button{
                        play = true
                        
                    } label : {
                        Image("playBtn")
                            .resizable()
                            .frame(width: size.width / 5, height: size.width / 5.5)
                            .position(x: size.width / 2, y: size.height / 1.4)
                        
                    }
                }
            }.ignoresSafeArea(.all)
        }
    }
}

#Preview {
    firstView()
}
