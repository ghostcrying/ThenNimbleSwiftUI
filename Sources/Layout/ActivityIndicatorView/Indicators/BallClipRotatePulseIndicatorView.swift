//
//  BallClipRotatePulseIndicatorView.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/9.
//

import SwiftUI

struct BallClipRotatePulseIndicatorView: View {
    
    var duration: Double = 1
    
    @State private var inScale:  CGFloat = 1
    @State private var outScale: CGFloat = 1
    @State private var radians:  Double = 0
    
    var body: some View {
        GeometryReader { proxy in
            let w = min(proxy.size.width, proxy.size.height)
            ZStack {
                ZStack {
                    BallClipRotateMultipleShape()
                        .stroke()
                        .frame(width: w, height: w)
                    
                    BallClipRotateMultipleShape()
                        .stroke()
                        .rotation(.radians(.pi))
                        .frame(width: w, height: w)
                }
                .rotationEffect(.radians(radians))
                .scaleEffect(.init(width: outScale, height: outScale))
                
                Circle()
                    .fill()
                    .frame(width: w / 2, height: w / 2)
                    .scaleEffect(.init(width: inScale, height: inScale))
            }
        }
        .onAppear {
            let animation = Animation.timingCurve(0.09, 0.57, 0.49, 0.9, duration: duration)
            withAnimation(animation.repeatForever(autoreverses: false)) {
                radians = .pi * 2
            }
            withAnimation(animation.repeatForever()) {
                outScale = 0.6
                inScale = 0.3
            }
        }
    }
}

struct BallClipRotatePulseIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        BallClipRotatePulseIndicatorView()
            .frame(width: 100, height: 100)
    }
}
