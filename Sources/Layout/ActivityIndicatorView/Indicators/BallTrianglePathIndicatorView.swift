//
//  BallTrianglePathIndicatorView.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/10.
//

import SwiftUI

struct BallTrianglePathIndicatorView: View {
    
    var duration: Double = 1.5
    
    @State private var defaultOffsets: [CGSize] = [.zero, .zero, .zero]
    @State private var offsets: [CGSize] = [.zero, .zero, .zero]
    
    private let offsetsIndexs = [
        0 : [1, 2, 0],
        1 : [2, 0, 1],
        2 : [0, 1, 2]
    ]
    
    var body: some View {
        GeometryReader { proxy in
            let width = min(proxy.size.width, proxy.size.height)
            let circleSize = width / 5
            let offset = (width - circleSize) / 2
            ZStack(alignment: .center) {
                ForEach(0..<3, id: \.self) { i in
                    Circle()
                        .fill()
                        .offset(offsets[i])
                        .frame(width: circleSize, height: circleSize)
                }
            }
            .offset(x: offset, y: offset)
            .onAppear {
                defaultOffsets = [
                    .init(width: 0, height: -offset),
                    .init(width: offset, height: offset),
                    .init(width: -offset, height: offset),
                ]
                offsets = defaultOffsets
                Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { _ in
                    let d = duration / 3
                    for (key, indexs) in offsetsIndexs {
                        for (i, value) in indexs.enumerated() {
                            withAnimation(.easeInOut(duration: d).delay(d * Double(i))) {
                                offsets[key] = defaultOffsets[value]
                            }
                        }
                    }
                }
            }
        }
    }
    
    
}

struct BallTrianglePathIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        BallTrianglePathIndicatorView()
            .frame(width: 100, height: 100)
    }
}
