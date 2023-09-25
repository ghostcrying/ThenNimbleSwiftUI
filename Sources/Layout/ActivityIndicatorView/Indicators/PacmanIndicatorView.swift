//
//  PacmanIndicatorView.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/8.
//

import SwiftUI

struct PacmanIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        PacmanIndicatorView()
            .frame(width: 100, height: 100)
            .foregroundColor(Color.orange.opacity(0.2))
    }
}

struct PacmanIndicatorView: View {

    var duration: Double = 0.5
    
    @State private var isPacmanOpen = false
    @State private var opacity: Double = 1
        
    var body: some View {
        GeometryReader { geometry in
            let w = min(geometry.size.width, geometry.size.height)
            let pacmanWidth = w / 3 * 2
            let foodWidth = w * 0.2
            HStack(spacing: 0) {
                PacmanShape(animatingMouth: isPacmanOpen)
                    .fill(style: .init(eoFill: true))
                    .frame(width: pacmanWidth, height: pacmanWidth)
                    .animation(.linear(duration: duration).repeatForever(autoreverses: true), value: isPacmanOpen)
                Circle()
                    .fill()
                    .frame(width: foodWidth, height: foodWidth)
                    .opacity(opacity)
                    .offset(x: opacity * (w * 0.5 + foodWidth * 2))
                    .animation(.linear(duration: duration).repeatForever(autoreverses: false), value: opacity)
                    .offset(x: -w * 0.5 - foodWidth)
            }
        }
        .onAppear {
            isPacmanOpen.toggle()
            opacity = 0
        }
    }
}

struct PacmanShape: Shape {
    
    var animatableData: Double
    init(animatingMouth: Bool) {
        animatableData = animatingMouth ? 1 : 0
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        path.move(to: center)
        
        let startAngle: Angle = .degrees(45 + (-45 * Double(animatableData)))
        /// 此处必须要进行偏差设定, 否则页面会出现闪屏
        let endedAngle: Angle = .degrees(-45 + (44.999 * Double(animatableData)))
        
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endedAngle, clockwise: false)
        
        // eye
        let eyePosition = CGPoint(x: rect.minX + rect.width * 0.65, y: rect.minY + rect.height * 0.2)
        let eyeRadius = rect.width * 0.05
        let eyeDiameter = eyeRadius * 2
        let eyeRect = CGRect(origin: CGPoint(x: eyePosition.x - eyeRadius,
                                             y: eyePosition.y - eyeRadius),
                             size: CGSize(width: eyeDiameter,
                                          height: eyeDiameter))
        path.addEllipse(in: eyeRect)
        
        return path
    }
    
}
