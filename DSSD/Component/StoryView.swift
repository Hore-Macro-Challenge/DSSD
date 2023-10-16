//
//  Story.swift
//  DSSD
//
//  Created by Aiffah Kiysa Waafi on 13/10/23.
//

import SwiftUI

struct StoryView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @StateObject private var viewModel = StoryViewModel()
    @State private var timeRemaining: Double = 10
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            storyOneView(
                size: size,
                text: viewModel.getCurrentStory().text)
        }
        .onReceive(timer) { _ in
            if viewModel.stories[viewModel.currentIndex].timeRemaining <= 1 {
                viewModel.moveToNextStory()
            } else {
                viewModel.stories[viewModel.currentIndex].timeRemaining -= 1
            }
        }
    }
    
    func storyOneView(size: CGSize, text: String) -> some View {
        ZStack(alignment: .leading){
            Rectangle()
                .foregroundColor(.black)
                .frame(width: size.width - (size.width/6), height: size.height - (size.height/1.15))
                .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                .cornerRadius(13)
                .background(RoundedRectangle(cornerRadius: 13, style: .continuous)
                    .stroke(Color(red: 0.5, green: 0.5, blue: 0.5), lineWidth: 5))
                .padding(.horizontal, 20)
                .position(x: size.width/2, y: size.height/1.12)
            Image("Person")
                .position(x: size.width/8, y: size.height/1.1)
            Text(text)
                .foregroundColor(.white)
                .font(.title)
                .position(x: size.width/2, y: size.height/1.12)
        }
    }
}