//
//  ContentView.swift
//  Memorize
//
//  Created by Cathy Chen on 2022-06-07.
//

import SwiftUI

struct ContentView: View {
    var myEmojis = ["🍏", "🍎", "🍊","🍇", "🍓",
                    "🍋","🍑","🥭","🍍","🥥",
                    "🥝", "🍅", "🍆", "🥑", "🥦",
                    "🥬", "🥒"]
    @State var emojiCount = 4
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]){
                    ForEach(myEmojis[0..<emojiCount], id:\.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            .padding()
            Spacer()
            HStack {
                remove
                Spacer()
                add
            }
        }
        .font(.largeTitle)
    }
    
    var add: some View {
        Button(action: {
            if emojiCount < myEmojis.count {
                emojiCount += 1
            }},
               label: {
            Image(systemName: "plus.circle")
        })
    }
    
    var remove: some View {
        Button(action: {
            if emojiCount > 1 {
                emojiCount -= 1
            }},
               label: {
            Image(systemName: "minus.circle")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
    }
}

struct CardView: View{
    @State var isFaceUp: Bool = true
    var content: String
    
    var body: some View {
        ZStack() {
            let shape = RoundedRectangle(cornerRadius: 10)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 3)
               Text(content)
            } else {
                shape.fill()
            }
       }
        .onTapGesture{
            isFaceUp = !isFaceUp
        }
    }
}
