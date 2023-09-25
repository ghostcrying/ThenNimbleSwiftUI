//
//  BallClipRotateIndicatorView.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/9.
//

import SwiftUI

struct BallClipRotateIndicatorView: View {
    
    var duration: Double = 0.75
    
    @State private var angle: Double = 0
    @State private var scale: Double = 1.0
    
    var body: some View {
        GeometryReader { proxy in
            let w = min(proxy.size.width, proxy.size.height)
            BallClipRotateShape()
                .stroke(lineWidth: 2)
                .rotationEffect(.radians(angle))
                .scaleEffect(.init(width: scale, height: scale))
                .frame(width: w, height: w)
        }
        .onAppear {
            withAnimation(.linear(duration: duration).repeatForever(autoreverses: false)) {
                angle = .pi * 2
            }
            withAnimation(.linear(duration: duration).repeatForever()) {
                scale = 0.6
            }
        }
    }
}

struct BallClipRotateIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        BallClipRotateIndicatorView()
            .frame(width: 100, height: 100)
    }
}

struct BallClipRotateShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = min(rect.width, rect.height)
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        path.addArc(center: center, radius: radius / 2, startAngle: .radians(.pi / 2), endAngle: .radians(.pi * 2), clockwise: false)
        return path
    }
}
