//
//  BallClipRotateMultipleIndicatorView.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/9.
//

import SwiftUI

struct BallClipRotateMultipleIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        BallClipRotateMultipleIndicatorView()
            .frame(width: 100, height: 100)
    }
}

struct BallClipRotateMultipleIndicatorView: View {
    
    var duration: Double = 0.75
    
    @State private var scale: CGFloat = 1
    @State private var insideAngle: Double = 0
    @State private var outsideAngle: Double = 0
    
    var body: some View {
        GeometryReader { proxy in
            let w = min(proxy.size.width, proxy.size.height)
            ZStack {
                ZStack {
                    BallClipRotateMultipleShape()
                        .stroke(lineWidth: 2)
                        .frame(width: w, height: w)
                    BallClipRotateMultipleShape()
                        .rotation(.radians(.pi))
                        .stroke(lineWidth: 2)
                        .frame(width: w, height: w)
                }
                .rotationEffect(.radians(outsideAngle))
                .scaleEffect(.init(width: scale, height: scale))
                
                ZStack {
                    BallClipRotateMultipleShape()
                        .rotation(.radians(.pi * 0.5))
                        .stroke(lineWidth: 2)
                        .frame(width: w / 2, height: w / 2)
                    
                    BallClipRotateMultipleShape()
                        .rotation(.radians(.pi * 1.5))
                        .stroke(lineWidth: 2)
                        .frame(width: w / 2, height: w / 2)
                }
                .rotationEffect(.radians(insideAngle))
                .scaleEffect(.init(width: scale, height: scale))
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: duration).repeatForever(autoreverses: false)) {
                outsideAngle = .pi * 2
                insideAngle = -.pi * 2
            }
            withAnimation(.easeInOut(duration: duration).repeatForever()) {
                scale = 0.5
            }
        }
    }
}

struct BallClipRotateMultipleShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = min(rect.width, rect.height)
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        
        path.addArc(center: center, radius: radius / 2, startAngle: .radians(0), endAngle: .radians(.pi / 2), clockwise: false)
        
        return path
    }
    
}
