//
//  CirclePendulumIndicatorView.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/8.
//

import SwiftUI

struct CirclePendulumIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        CirclePendulumIndicatorView()
            .frame(width: 100, height: 100)
    }
}

struct CirclePendulumIndicatorView: View {
    
    var duration: Double = 1
    
    private let count = 3
    private let ratio: CGFloat = 7
    
    @State private var angle0: Double = 0
    @State private var angle1: Double = 0
    @State private var angle2: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            let w = geometry.size.width / ratio
            let h = geometry.size.height - w
            let offset = geometry.size.width / 2 - w / 2
            let angle = Double(atan(w / (geometry.size.height - w / 2)))
            ZStack(alignment: .center) {
                Circle()
                    .fill()
                    .frame(width: w, height: w)
                    .offset(x: 0, y: h)
                    .rotationEffect(Angle(radians: angle))
                    .rotationEffect(Angle(radians: angle0))
                
                Circle()
                    .fill()
                    .frame(width: w, height: w)
                    .offset(x: 0, y: h)
                    .rotationEffect(Angle(radians: angle1))
                
                Circle()
                    .fill()
                    .frame(width: w, height: w)
                    .offset(x: 0, y: h)
                    .rotationEffect(Angle(radians: -angle))
                    .rotationEffect(Angle(radians: angle2))
            }
            .offset(x: offset)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: duration * 3, repeats: true) { _ in
                    withAnimation(.easeInOut(duration: duration)) {
                        angle0 += Double.pi * 2 - angle * 2
                        angle1 += angle
                        angle2 += angle
                    }
                    withAnimation(.easeInOut(duration: duration).delay(duration)) {
                        angle0 += angle
                        angle1 += Double.pi * 2 - angle * 2
                        angle2 += angle
                    }
                    withAnimation(.easeInOut(duration: duration).delay(duration * 2)) {
                        angle0 += angle
                        angle1 += angle
                        angle2 += Double.pi * 2 - angle * 2
                    }
                }
                .fire()
            }
        }
    }
}
