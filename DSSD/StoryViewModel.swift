//
//  StoryViewModel.swift
//  DSSD
//
//  Created by Aiffah Kiysa Waafi on 13/10/23.
//

import Foundation
import SwiftUI

class StoryViewModel: ObservableObject {
    @Published var stories: [Story] = [
        Story(id: 1, text: "MATIKAN ALARM"),
        Story(id: 2, text: "Ini story 222"),
        Story(id: 3, text: "SELESAIII")
    ]
    
    @Published var currentIndex: Int = 0
    
    func getCurrentStory() -> Story {
        return stories[currentIndex]
    }

    func moveToNextStory() {
        if currentIndex == stories.count - 1 {
            currentIndex = stories.count - 1
        } else {
            currentIndex += 1
        }
    }
}
