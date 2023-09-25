//
//  BallZigZagDeflectIndicatorView.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/10.
//

import SwiftUI

struct BallZigZagDeflectIndicatorView: View {
    
    var duration: Double = 0.25
    
    /// 动态点位
    @State private var topOffset = CGSize()
    @State private var botOffset = CGSize()
    
    /// 默认点位
    @State private var offsets: [CGSize] = []
    
    var body: some View {
        GeometryReader { proxy in
            let width = min(proxy.size.width, proxy.size.height)
            let circleSize = width / 5
            let offset = (width - circleSize) / 2
            ZStack {
                Circle()
                    .fill()
                    .frame(width: circleSize, height: circleSize)
                    .offset(topOffset)
                
                Circle()
                    .fill()
                    .frame(width: circleSize, height: circleSize)
                    .offset(botOffset)
            }
            .offset(.init(width: offset, height: offset))
            .onAppear {
                offsets = [
                    .init(width: -offset, height: -offset),
                    .init(width: offset, height: -offset),
                    .init(width: 0, height: 0),
                    
                    .init(width: offset, height: -offset),
                    .init(width: -offset, height: -offset),
                    .init(width: 0, height: 0),
                    
                    .init(width: offset, height: offset),
                    .init(width: -offset, height: offset),
                    .init(width: 0, height: 0),
                    
                    .init(width: -offset, height: offset),
                    .init(width: offset, height: offset),
                    .init(width: 0, height: 0),
                ]
                Timer.scheduledTimer(withTimeInterval: duration * 6, repeats: true) { _ in
                    (0..<6).forEach { i in
                        withAnimation(.linear(duration: duration).delay(duration * Double(i))) {
                            topOffset = offsets[i]
                            botOffset = offsets[i + 6]
                        }
                    }
                }
            }
        }
    }
}

struct BallZigZagDeflectIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        BallZigZagDeflectIndicatorView()
            .frame(width: 100, height: 100)
    }
}
