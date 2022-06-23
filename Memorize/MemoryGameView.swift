//
//  MemoryGameView.swift
//  Memorize
//
//  Created by Cathy Chen on 2022-06-07.
// View is to reflect the model

import SwiftUI

struct MemoryGameView: View {
    //Create viewModel that subscribe to EmojiMemoryGame viewmodel
   @ObservedObject var game: EmojiMemoryGame

    var body: some View {
        VStack(alignment: .center) {
            //Text("Memorize")
               // .font(.largeTitle)
            Text("\(EmojiMemoryGame.currentTheme.name)")
                .font(.title).bold()
            gamebody
            HStack{
                VStack(spacing: 5) {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 1)) {
                            game.startNewGame()
                        }
                    },
                    label:{
                        Text("New Game")})
                    shuffle
                }
                .font(.headline)
                Spacer()
                Text("Score: \(game.getScore())")
                    .foregroundColor(.white)
                    .font(.title)
            }.padding(10)
        }
        .padding(10)
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    var gamebody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if isUndealt(card) || (card.isMatched && !card.isFaceUp){
                Color.clear
            } else{
                CardView(card: card)
                    .padding(3)
                    .transition(AnyTransition.opacity.animation(Animation.easeInOut(duration: 0.5)))
                    .onTapGesture {
                        withAnimation() {
                            game.choose(card) //Express intent to choose a card
                        }
                    }
                }
            }
            .onAppear {
                // "deal" cards
                withAnimation {
                    for card in game.cards {
                        deal(card)
                    }
                }
        }
        .foregroundColor(Color(EmojiMemoryGame.currentTheme.colour))
        .padding(.horizontal)
    }
    
    var shuffle: some View
    {
        Button("Shuffle") {
            withAnimation(.easeInOut(duration: 1)) {
                game.shuffle()
            }
        }
    }
}

//Create the entire card view
struct CardView: View {
    let card: MemoryGame<String>.Card //Card
    
    var body: some View {
        GeometryReader(content: {geometry in
            ZStack() {
                Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 45), clockwise: false)
                    .padding(5)
                    .opacity(0.5)
                Text(card.content)
                    .font(font(in: geometry.size))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.easeInOut(duration: 1))
                    .scaleEffect(scale(thatFits: geometry.size))
           }
            .cardify(isFaceUp: card.isFaceUp)
        })
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size:min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.6
        static let fontSize: CGFloat = 48
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
