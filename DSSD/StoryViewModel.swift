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
        Story(id: 1, text: "Wah hari sudah pagi! Saatnya memulai hari!"),
        Story(id: 2, text: "Bunyi apa ini? Oh ini bunyi alarm"),
        Story(id: 3, text: "Aku Harus mematikan Alarm"),
        Story(id: 4, text: "Tekan Tombol yang ditunjuk"),
        Story(id: 5, text: "Hari sudah cerah, aku harus membuka gorden"),
        Story(id: 6, text: "Geser gorden ke kanan dan ke kiri"),
        Story(id: 7, text: "Sepertinya lampu tidurnya sudah tidak diperlukan lagi"),
        Story(id: 8, text: "Aku Harus mematikan lampu tidur"),
        Story(id: 9, text: "Tekan saklar")
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
