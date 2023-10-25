//
//  RefreshActivityIndicator.swift
//  Example
//
//  Created by 大大 on 2023/10/24.
//

import SwiftUI

// MARK: - IndicatorView_Previews

struct RefreshActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        RefreshActivityIndicator(state: .loading, progress: 0.5)
    }
}

// MARK: - IndicatorView

public struct RefreshActivityIndicator: View {
    
    public let state: RefreshState
    public let progress: Double
    
    private let count: Int = 8
    
    @State private var isAnimate: Bool = false
    @State private var angle: Double = 0

    public var body: some View {
        GeometryReader { geometry in
            switch state {
            case .waiting:
                EmptyView()
            default:
                ForEach(0..<count, id: \.self) { index in
                    switch progress {
                    case 0..<1:
                        RefreshActivityIndicatorItem(index: index, count: count, size: geometry.size, opacity: getOpacity(index))
                    default:
                        if isAnimate {
                            RefreshActivityIndicatorAnimateItem(pace: Double(index) / Double(count), size: geometry.size)
                        } else {
                            RefreshActivityIndicatorItem(index: index, count: count, size: geometry.size, opacity: getOpacity(index))
                                .rotationEffect(.degrees(angle))
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        angle = 45
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        isAnimate = true
                                    }
                                }
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .foregroundColor(.red)
        .frame(width: state.loadingSize.width, height: state.loadingSize.height)
    }
    
    private func getOpacity(_ index: Int) -> Double {
        let p = 1 / Double(count) * Double(index)
        switch progress {
        case 0..<p:
            return 0
        case p..<p+0.125:
            return (progress - p) * 8
        default:
            return 1
        }
    }
}

// MARK: - DefaultIndicatorItemView

struct RefreshActivityIndicatorAnimateItem: View {
    let pace: Double
    let size: CGSize

    @State private var opacity: Double = 0

    var body: some View {
        let height = self.size.height / 3.2
        let width = height / 2
        // 第一个始终在最上方
        let angle: Double = 2 * .pi * pace - .pi / 4
        let x = (size.width / 2 - height / 2) * cos(angle)
        let y = (size.height / 2 - height / 2) * sin(angle)

        let animation = Animation
            .default
            .repeatForever(autoreverses: true)
            .delay(pace / 2)

        return RoundedRectangle(cornerRadius: width / 2 + 1)
            .frame(width: width, height: height)
            .rotationEffect(Angle(radians: angle + .pi / 2))
            .offset(x: x, y: y)
            .opacity(opacity)
            .onAppear {
                self.opacity = 1
                withAnimation(animation) {
                    self.opacity = 0.3
                }
            }
    }
}

struct RefreshActivityIndicatorItem: View {
    let index: Int
    let count: Int
    let size: CGSize
    let opacity: Double

    var body: some View {
        let height = self.size.height / 3.2
        let width = height / 2
        // 第一个始终在最上方
        let angle: Double = 2 * .pi / Double(self.count) * Double(self.index) - .pi / 2
        let x = (size.width / 2 - height / 2) * cos(angle)
        let y = (size.height / 2 - height / 2) * sin(angle)

        return RoundedRectangle(cornerRadius: width / 2 + 1)
            .frame(width: width, height: height)
            .rotationEffect(Angle(radians: angle + .pi / 2))
            .offset(x: x, y: y)
            .opacity(opacity)
    }
}
