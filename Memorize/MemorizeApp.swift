//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Cathy Chen on 2022-06-07.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            MemoryGameView(viewModel: game)
        }
    }
}
