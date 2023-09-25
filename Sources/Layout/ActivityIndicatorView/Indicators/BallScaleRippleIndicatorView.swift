//
//  BallScaleRippleIndicatorView.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/10.
//

import SwiftUI

struct BallScaleRippleIndicatorView: View {
    
    var duration: Double = 1
    
    @State private var scale: CGFloat = 0
    @State private var opacity: Double = 0
    
    var body: some View {
        GeometryReader { proxy in
            Circle()
                .stroke(lineWidth: 2)
                .frame(width: proxy.size.width, height: proxy.size.height)
                .scaleEffect(x: scale, y: scale)
                .opacity(opacity)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { _ in
                    scale = 0.1
                    opacity = 1
                    withAnimation(.timingCurve(0.21, 0.53, 0.56, 0.8, duration: 0.7 * duration)) {
                        scale = 1
                        opacity = 0.7
                    }
                    withAnimation(.timingCurve(0.21, 0.53, 0.56, 0.8, duration: 0.3 * duration).delay(duration * 0.7)) {
                        opacity = 0
                    }
                }
                .fire()
            }
        }
    }
}

struct BallScaleRippleIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        BallScaleRippleIndicatorView()
            .frame(width: 100, height: 100)
    }
}
