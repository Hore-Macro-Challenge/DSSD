//
//  Bedroom.swift
//  DSSD
//
//  Created by Aiffah Kiysa Waafi on 13/10/23.
//

import SwiftUI

struct Bedroom: View {
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ZStack{
                Image("Bedroom")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                HStack{
                    StoryView()
                }
            }
        }.ignoresSafeArea()
    }
}

struct Bedroom_Previews: PreviewProvider {
    static var previews: some View {
        Bedroom()
    }
}

