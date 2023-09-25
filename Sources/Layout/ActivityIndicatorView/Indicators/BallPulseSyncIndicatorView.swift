//
//  BallPulseSyncIndicatorView.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/9.
//

import SwiftUI

struct BallPulseSyncIndicatorView: View {
    
    var duration: Double = 0.6
    
    private let circleSpacing: CGFloat = 2
    private let beginTimes: [Double] = [0.07, 0.14, 0.21]
    
    @State private var offsets = [Double](repeating: 0, count: 3)
        
    var body: some View {
        GeometryReader { proxy in
            let w = min(proxy.size.width, proxy.size.height)
            let circleSize = (w - circleSpacing * 2) / 3
            let delta = w / 4
            HStack(spacing: circleSpacing) {
                ForEach(0..<3, id: \.self) { i in
                    Circle()
                        .fill()
                        .frame(width: circleSize, height: circleSize)
                        .offset(y: offsets[i])
                }
            }
            .onAppear {
                let d = duration / 3.0
                Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { _ in
                    for i in 0..<3 {
                        for j in 0..<3 {
                            withAnimation(.easeInOut(duration: d).delay(beginTimes[i] + d * Double(j))) {
                                switch j {
                                case 0:
                                    offsets[i] = delta
                                case 1:
                                    offsets[i] = -delta
                                default:
                                    offsets[i] = 0
                                }
                            }
                        }
                    }
                }
                .fire()
            }
        }
    }
    
}

struct BallPulseSyncIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        BallPulseSyncIndicatorView()
            .frame(width: 100, height: 100)
    }
}
