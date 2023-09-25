//
//  OrbitIndicatorView.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/9.
//

import SwiftUI

struct OrbitIndicatorView: View {
    
    // MARK: - Public Properties
    var duration: Double = 2.0
    
    // MARK: - Private Properties
    private let satelliteCoreRatio: CGFloat = 0.25
    private let distanceRatio: CGFloat = 1.5
    
    // MARK: - State Properties
    @State private var starScale: Double = 1
    @State private var satelliteAngle: Double = 0
    @State private var rippleOpacity: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            let w = min(geometry.size.width, geometry.size.height)
            // 行星尺寸
            let coreSize = w / (1 + satelliteCoreRatio + distanceRatio)
            // 卫星尺寸
            let satelliteSize = coreSize * satelliteCoreRatio
            ///偏移
            let offset = w / 2 - coreSize / 2
            ZStack(alignment: .center) {
                Circle()
                    .fill()
                    .frame(width: coreSize, height: coreSize)
                    .scaleEffect(CGSize(width: starScale, height: starScale))
                
                Circle()
                    .fill()
                    .frame(width: coreSize, height: coreSize)
                    .scaleEffect(1.8 - rippleOpacity)
                    .opacity(rippleOpacity)
                
                Circle()
                    .fill()
                    .frame(width: satelliteSize)
                    .offset(x: w / 2 - satelliteSize / 2)
                    .rotationEffect(.radians(satelliteAngle))
            }
            .offset(x: offset, y: offset)
        }
        .onAppear {
            let insAnimation = Animation.timingCurve(0.7, 0, 1, 0.5, duration: duration)
            let outAnimation = Animation.timingCurve(0, 0.7, 0.5, 1, duration: duration)
            Timer.scheduledTimer(withTimeInterval: duration * 2, repeats: true) { _ in
                withAnimation(insAnimation) {
                    starScale = 1.3
                }
                withAnimation(outAnimation.delay(duration)) {
                    starScale = 1
                }
            }
            .fire()
            let t = Timer.scheduledTimer(withTimeInterval: duration * 2, repeats: true) { _ in
                rippleOpacity = 0.5
                withAnimation(.timingCurve(curve: .easeOutExpo, duration: duration)) {
                    rippleOpacity = 0
                }
            }
            t.fireDate = .init(timeIntervalSinceNow: 1.99)
                        
            withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                satelliteAngle = .pi * 2
            }
        }
    }
}

struct OrbitIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        OrbitIndicatorView()
            .frame(width: 120, height: 120)
    }
}
