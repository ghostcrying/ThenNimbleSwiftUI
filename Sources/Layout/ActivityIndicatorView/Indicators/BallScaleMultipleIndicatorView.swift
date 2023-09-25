//
//  BallScaleMultipleIndicatorView.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/10.
//

import SwiftUI

struct BallScaleMultipleIndicatorView: View {
    
    var duration: Double = 1
    
    @State var opacitys: [Double] = .init(repeating: 1, count: 3)
    
    private let beginTimes: [Double] = [0, 0.2, 0.4]
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(0..<3, id: \.self) { i in
                    Circle()
                        .fill()
                        .opacity(opacitys[i])
                        .scaleEffect(x: 1 - opacitys[i], y: 1 - opacitys[i])
                        .animation(
                            .linear(duration: duration).delay(beginTimes[i]).repeatForever(autoreverses: false),
                            value: opacitys[i]
                        )
                        .frame(width: proxy.size.width, height: proxy.size.height)
                }
            }
            .onAppear {
                opacitys = [0, 0, 0]
            }
        }
    }
}

struct BallScaleMultipleIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        BallScaleMultipleIndicatorView()
            .frame(width: 100, height: 100)
    }
}
