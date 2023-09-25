//
//  BallGridBeatIndicatorView.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/9.
//

import SwiftUI

struct BallGridBeatIndicatorView: View {
    
    @State private var opacity: Double = 1
    
    private let circleSpacing: CGFloat = 2
    private let circleCount:   CGFloat = 9
    private let durations: [Double] = [0.96, 0.93, 1.19, 1.13, 1.34, 0.94, 1.2, 0.82, 1.19]
    private let beginTimes: [Double] = [0.36, 0.4, 0.68, 0.41, 0.71, -0.15, -0.12, 0.01, 0.32]
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
                                .animation(aniamtion, value: opacity)
                        }
                    }
                }
            }
        }
        .onAppear {
            opacity = 0.37
        }
    }
}

struct BallGridBeatIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        BallGridBeatIndicatorView()
            .frame(width: 100, height: 100)
    }
}
