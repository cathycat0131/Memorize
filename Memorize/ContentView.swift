//
//  ContentView.swift
//  Memorize
//
//  Created by Cathy Chen on 2022-06-07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        return ZStack() {
            RoundedRectangle(cornerRadius: 25.0)
                .stroke(lineWidth: 3)
                .padding(.horizontal)
            Text("Hello, world!")
        }
        .padding(.horizontal)
        .foregroundColor(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
