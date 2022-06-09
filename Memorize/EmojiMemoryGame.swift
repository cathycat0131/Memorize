//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Cathy Chen on 2022-06-09.
// ViewModel

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static var themes: Array<Theme> = [Theme(name: "Fruit", myEmojis: ["🍏", "🍎", "🍊","🍇", "🍓",
                                                                "🍋","🍑","🥭","🍍","🥥",
                                                                "🥝", "🍅", "🍆", "🥑", "🥦",
                                                                "🥬", "🥒"], numOfPair: 8, colour: .systemPink),
                                Theme(name: "Car", myEmojis: ["🚗", "🚕", "🚙", "🚌", "🚎",
                                                              "🏎", "🚓", "🚑", "🚒", "🚐",
                                                              "🛻", "🚚","🚛", "🚜", "🛵"], numOfPair: 8, colour: .purple)]
    static var currentTheme = themes[Int.random(in: 0..<2)]
    
    //Function to populate card content for the game
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: currentTheme.numOfPair ) { pairIndex in
            currentTheme.myEmojis[pairIndex] //Content of the card
        }
    }
        
    //Automatically update the model
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    //Retrieve the array of cards for the game
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    //MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        return model.choose(card)
    }
    
    func getScore() -> Int {
        return model.score
    }
    
    func startNewGame(){
        EmojiMemoryGame.currentTheme = EmojiMemoryGame.themes[Int.random(in: 0..<2)]
        model = EmojiMemoryGame.createMemoryGame()
    }
    
}

