//
//  MemoryGameView.swift
//  Memorize
//
//  Created by Cathy Chen on 2022-06-07.
// View is to reflect the model

import SwiftUI

struct MemoryGameView: View {
   @ObservedObject var game: EmojiMemoryGame //Create viewModel that subscribe to EmojiMemoryGame viewmodel

    var body: some View {
        //Text("Memorize")
        VStack {
            Text("\(EmojiMemoryGame.currentTheme.name)")
                .font(.largeTitle)
            AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card) //Express intent to choose a card
                    }
                })
            .foregroundColor(Color(EmojiMemoryGame.currentTheme.colour))
            .padding(.horizontal)
            .opacity(0.8)
            HStack {
                Button(action: {
                    game.startNewGame()
                },
                label:{
                    Text("New Game")})
                Spacer()
                Text("Score: \(game.getScore())")
                    .foregroundColor(.white)
                    .font(.title)
            }.padding(20)
        }
    }
}

//Create the entire card view
struct CardView: View {
    let card: MemoryGame<String>.Card //Card
    
    var body: some View {
        GeometryReader(content: {geometry in
            ZStack() {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius) //Create each card shape
                if card.isFaceUp { //Turn over card
                    shape.fill().foregroundColor(.white)
                    shape.stroke(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0) //Remove card
                } else {
                    shape.fill() //Turn down card
                }
           }
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size:min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        MemoryGameView(game: game)
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
    }
}
