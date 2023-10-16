//
//  Story.swift
//  DSSD
//
//  Created by Aiffah Kiysa Waafi on 13/10/23.
//

import SwiftUI

struct StoryView: View {
    @StateObject private var viewModel = StoryViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            storyOneView(
                size: size,
                text: viewModel.getCurrentStory().text)
        }
    }
    
    func storyOneView(size: CGSize, text: String) -> some View {
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
            Text(text)
                .foregroundColor(.black)
                .font(.custom("ComicSansMS-Bold", size: 20))
                .position(x: size.width/2, y: size.height/1.12)
        }
    }
}
