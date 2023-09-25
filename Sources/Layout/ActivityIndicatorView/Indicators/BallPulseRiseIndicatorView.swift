//
//  BallPulseRiseIndicatorView.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/9.
//

import SwiftUI

struct BallPulseRiseIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        BallPulseRiseIndicatorView()
            .frame(width: 100, height: 100)
    }
}

struct BallPulseRiseIndicatorView: View {
    
    var duration: Double = 1
    
    // even
    @State private var evenScale: CGFloat = 1.1
    @State private var evenOffsety: CGFloat = 0
    // odd
    @State private var oddScale: CGFloat = 0.4
    @State private var oddOffsety: CGFloat = 0
    
    private let circleSpacing: CGFloat = 2
    private let circleCount:   CGFloat = 5
    
    var body: some View {
        GeometryReader { proxy in
            let w = min(proxy.size.width, proxy.size.height)
            let circleSize = (w - 4 * circleSpacing) / circleCount
            let deltayY = w / 2
            HStack(spacing: circleSpacing) {
                ForEach(0..<5, id: \.self) { i in
                    Circle()
                        .fill()
                        .frame(width: circleSize, height: circleSize)
                        .scaleEffect(x: i % 2 == 0 ? evenScale : oddScale,
                                     y: i % 2 == 0 ? evenScale : oddScale)
                        .offset(y: i % 2 == 0 ? evenOffsety : oddOffsety)
                }
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    withAnimation(Animation.timingCurve(0.15, 0.46, 0.9, 0.6, duration: 0.25)) {
                        oddOffsety = deltayY
                        evenOffsety = -deltayY
                    }
                    withAnimation(Animation.timingCurve(0.15, 0.46, 0.9, 0.6, duration: 0.5).delay(0.25)) {
                        oddOffsety = -deltayY
                        evenOffsety = deltayY
                    }
                    withAnimation(Animation.timingCurve(0.15, 0.46, 0.9, 0.6, duration: 0.25).delay(0.75)) {
                        oddOffsety = 0
                        evenOffsety = 0
                    }
                }.fire()
                
                Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
                    withAnimation(Animation.timingCurve(0.15, 0.46, 0.9, 0.6, duration: 0.5)) {
                        oddScale = 1.1
                        evenScale = 0.4
                    }
                    withAnimation(Animation.timingCurve(0.15, 0.46, 0.9, 0.6, duration: 0.5).delay(0.5)) {
                        oddScale = 0.75
                        evenScale = 1.0
                    }
                    withAnimation(Animation.timingCurve(0.15, 0.46, 0.9, 0.6, duration: 0.5).delay(1)) {
                        oddScale = 0.4
                        evenScale = 1.1
                    }
                    
//                    withAnimations([
//                        .timingCurve(0.15, 0.46, 0.9, 0.6, duration: 0.5),
//                        .timingCurve(0.15, 0.46, 0.9, 0.6, duration: 0.5),
//                        .timingCurve(0.15, 0.46, 0.9, 0.6, duration: 0.5),
//                    ], begintimes: [0, 0.5, 1], actions: [
//                        {
//                            oddScale = 1.1
//                            evenScale = 0.4
//                        },
//                        {
//                            oddScale = 0.75
//                            evenScale = 1.0
//                        },
//                        {
//                            oddScale = 0.4
//                            evenScale = 1.1
//                        }
//                    ])
                }.fire()
            }
        }
    }
}

public typealias animationsClosure = () -> Void

// Animation: with no delay
public func withAnimations(_ animations: [Animation] = [], begintimes: [Double], actions: [animationsClosure]) {
    for (i, animation) in animations.enumerated() {
        withAnimation(animation.delay(begintimes[i])) {
            actions[i]()
        }
    }
}
