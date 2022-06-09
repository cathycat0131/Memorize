//
//  MemoryGame.swift
//  Memorize
//
//  Created by Cathy Chen on 2022-06-09.
// This is a game model

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card> //Read only array of cards
    
    private(set) var theme: Array<Theme>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? //The index of the only card that is up
    
    var score: Int = 0
    
    //Game logic to match cards
    mutating func choose(_ card: Card) {
        //Find the chosen card index
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }), !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched {
            //Check whether there is only one card faced up
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                //If there are two cards faced up
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    //If the two cards matched
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    score -= 1
                }
                //Set the index to null
                indexOfTheOneAndOnlyFaceUpCard = nil
            }
            //If there is no only index and one chose another card
            else {
                //Turn all the cards face down
                for index in 0..<cards.count {
                    cards[index].isFaceUp = false
                }
    
                //Set the new only index
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            //Turn the card
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    //Initialize cards for game
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        theme = Array<Theme>()
        var numInserted = 0
        //Add numberofpairsofcards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.insert(Card(content: content, id: pairIndex * 2), at: Int.random(in: 0...numInserted))
            numInserted += 1
            cards.insert(Card(content: content, id: pairIndex * 2 + 1), at: Int.random(in: 0...numInserted))
            numInserted += 1
        }
        
        theme.append(Theme(name: "fruit", myEmojis: ["🍏", "🍎", "🍊","🍇", "🍓",
                                          "🍋","🍑","🥭","🍍","🥥",
                                          "🥝", "🍅", "🍆", "🥑", "🥦",
                                                         "🥬", "🥒"], numOfPair: 6, colour: .red))
        theme.append(Theme(name: "car", myEmojis: ["🚗", "🚕", "🚙", "🚌", "🚎",
                                                   "🏎", "🚓", "🚑", "🚒", "🚐",
                                                  "🛻", "🚚","🚛", "🚜", "🛵"], numOfPair: 6, colour: .blue))
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
    
}
