//
//  MemoryGameView.swift
//  Memorize
//
//  Created by Cathy Chen on 2022-06-07.
// View is to reflect the model

import SwiftUI

struct MemoryGameView: View {
   @ObservedObject var viewModel: EmojiMemoryGame //Create viewModel that subscribe to EmojiMemoryGame viewmodel

    var body: some View {
        //Text("Memorize")
        VStack {
            Text("\(EmojiMemoryGame.currentTheme.name)")
                .font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]){
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card) //Express intent to choose a card
                            }
                    }
                }
            }
            .foregroundColor(Color(EmojiMemoryGame.currentTheme.colour))
            .padding(.horizontal)
            .opacity(0.8)
            HStack {
                Button(action: {
                    viewModel.startNewGame()
                },
                label:{
                    Text("New Game")})
                Spacer()
                Text("Score: \(viewModel.getScore())")
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
            ZStack() {
                let shape = RoundedRectangle(cornerRadius: 10) //Create each card shape
                if card.isFaceUp { //Turn over card
                    shape.fill().foregroundColor(.white)
                    shape.stroke(lineWidth: 3)
                    Text(card.content).font(.largeTitle)
                } else if card.isMatched {
                    shape.opacity(0) //Remove card
                } else {
                    shape.fill() //Turn down card
                }
           }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        MemoryGameView(viewModel: game)
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
    }
}
