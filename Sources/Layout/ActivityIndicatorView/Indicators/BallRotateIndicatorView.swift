//
//  BallRotateIndicatorView.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/10.
//

import SwiftUI

struct BallRotateIndicatorView: View {
    
    var duration: Double = 1
    
    @State private var scale: CGFloat = 0
    @State private var radian: Double = 0
    
    var body: some View {
        GeometryReader { proxy in
            let w = min(proxy.size.width, proxy.size.height)
            let circleSize = w / 5
            HStack(alignment: .center, spacing: (w - circleSize * 3) / 2) {
                Circle()
                    .fill()
                    .opacity(0.8)
                    .frame(width: circleSize, height: circleSize)
                
                Circle()
                    .fill()
                    .frame(width: circleSize, height: circleSize)
                
                Circle()
                    .fill()
                    .opacity(0.8)
                    .frame(width: circleSize, height: circleSize)
            }
            .rotationEffect(.radians(radian))
            .scaleEffect(x: scale, y: scale)
            .offset(y: w / 2 - circleSize / 2)
            .onAppear {
                let d = duration / 2
                let animation = Animation.timingCurve(0.7, -0.13, 0.22, 0.86, duration: d)
                Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { _ in
                    withAnimation(animation) {
                        radian += .pi
                        scale = 0.6
                    }
                    withAnimation(animation.delay(d)) {
                        radian += .pi
                        scale = 1
                    }
                }
                .fire()
            }
        }
    }
}

struct BallRotateIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        BallRotateIndicatorView()
            .frame(width: 100, height: 100)
    }
}
