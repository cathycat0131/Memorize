//
//  Cardify.swift
//  Memorize
//
//  Created by Cathy Chen on 2022-06-16.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    //var isFaceUp: Bool
    
    var rotation: Double // in degrees
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool){
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack() {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius) //Create each card shape
            if rotation < 90 { //Turn over card
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: DrawingConstants.lineWidth)
            } else {
                shape.fill() //Turn down card
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
       }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0 ))
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}


