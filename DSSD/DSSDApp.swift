//
//  DSSDApp.swift
//  DSSD
//
//  Created by Aiffah Kiysa Waafi on 13/10/23.
//

import SwiftUI

@main
struct DSSDApp: App {
    @AppStorage("character") var character: String = ""
    var body: some Scene {
        WindowGroup {
            if character == "girl" || character == "boy"{
                secondView()
            } else{
                firstView()
            }
        }
    }
}
