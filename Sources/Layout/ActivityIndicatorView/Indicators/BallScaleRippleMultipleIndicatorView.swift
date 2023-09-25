//
//  BallScaleRippleMultipleIndicatorView.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/10.
//

import SwiftUI

struct BallScaleRippleMultipleIndicatorView: View {
    
    var duration: Double = 1
    
    @State private var scales: [CGFloat] = .init(repeating: 0.1, count: 3)
    @State private var opacitys: [Double] = .init(repeating: 1, count: 3)
    
    private let beginTimes: [Double] = [0.0, 0.2, 0.4]
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(0..<3, id: \.self) { i in
                    Circle()
                        .stroke(lineWidth: 2)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .scaleEffect(x: scales[i], y: scales[i])
                        .opacity(opacitys[i])
                }
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { _ in
                    (0..<3).forEach { i in
                        scales[i] = 0.1
                        opacitys[i] = 1.0
                        withAnimation(.timingCurve(0.21, 0.53, 0.56, 0.8, duration: 0.7 * duration).delay(beginTimes[i])) {
                            scales[i] = 1.0
                            opacitys[i] = 0.7
                        }
                        withAnimation(.timingCurve(0.21, 0.53, 0.56, 0.8, duration: 0.3 * duration).delay(beginTimes[i] + duration * 0.7)) {
                            opacitys[i] = 0.0
                        }
                    }
                }
                .fire()
            }
        }
    }
}

struct BallScaleRippleMultipleIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        BallScaleRippleMultipleIndicatorView()
            .frame(width: 100, height: 100)
            .foregroundColor(.white)
            .background(Color.gray)
    }
}
