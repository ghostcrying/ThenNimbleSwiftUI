//
//  BallGridPulseIndicatorView.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/9.
//

import SwiftUI

struct BallGridPulseIndicatorView: View {
    
    @State private var opacity: Double = 1
    @State private var scale: CGFloat = 1
    
    private let circleSpacing: CGFloat = 2
    private let circleCount:   CGFloat = 9
    private let durations: [Double] = [0.72, 1.02, 1.28, 1.42, 1.45, 1.18, 0.87, 1.45, 1.06]
    private let beginTimes: [Double] = [-0.06, 0.25, -0.17, 0.48, 0.31, 0.03, 0.46, 0.78, 0.45]
    
    var body: some View {
        GeometryReader { proxy in
            let w = min(proxy.size.width, proxy.size.height)
            let circleSize = (w - circleSpacing * 2) / 3
            VStack(spacing: circleSpacing) {
                ForEach(0..<3, id: \.self) { i in
                    HStack(spacing: circleSpacing) {
                        ForEach(0..<3, id: \.self) { j in
                            let aniamtion: Animation =
                                .linear(duration: durations[3 * i + j])
                                .delay(beginTimes[3 * i + j])
                                .repeatForever()
                            Circle()
                                .fill()
                                .frame(width: circleSize, height: circleSize)
                                .opacity(opacity)
                                .scaleEffect(x: scale, y: scale)
                                .animation(aniamtion, value: opacity)
                        }
                    }
                }
            }
        }
        .onAppear {
            opacity = 0.37
            scale = 0.5
        }
    }
}

struct BallGridPulseIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        BallGridPulseIndicatorView()
            .frame(width: 100, height: 100)
    }
}
