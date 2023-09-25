//
//  ContentView.swift
//  Example
//
//  Created by 陈卓 on 2023/8/7.
//

import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentView: View {
    
    @State var angle: Double = 0

    var body: some View {
        VStack {
            Rectangle()
                .fill()
                .frame(width: 100, height: 10)
                .rotationEffect(.degrees(angle))
        }
        .onAnimationCompleted(for: angle, completion: {
            print(Date())
        })
        .onAppear {
            withAnimation(.linear(duration: 1).repeatForever()) {
                angle = 100
            }
        }
    }
    
}
