//
//  File.swift
//  
//
//  Created by 陈卓 on 2023/8/7.
//

import Foundation

#if canImport(UIKit)
import UIKit
#endif
#if canImport(AppKit)
import AppKit
#endif

extension CGPoint {
    
    static var pointFarAwayFromScreen: CGPoint {
        CGPoint(x: 2 * CGSize.screenSize.width, y: 2 * CGSize.screenSize.height)
    }
}

public extension CGSize {
    
    static var screenSize: CGSize {
#if os(iOS) || os(tvOS)
        return UIScreen.main.bounds.size
#elseif os(watchOS)
        return WKInterfaceDevice.current().screenBounds.size
#elseif os(macOS)
        return NSScreen.main?.frame.size ?? .zero
#endif
    }
}


import SwiftUI

public extension Animation {
    
    enum TimingCurve {
        case easeInSine
        case easeOutSine
        case easeInOutSine
        case easeInQuad
        case easeOutQuad
        case easeInOutQuad
        case easeInCubic
        case easeOutCubic
        case easeInOutCubic
        case easeInQuart
        case easeOutQuart
        case easeInOutQuart
        case easeInQuint
        case easeOutQuint
        case easeInOutQuint
        case easeInExpo
        case easeOutExpo
        case easeInOutExpo
        case easeInCirc
        case easeOutCirc
        case easeInOutCirc
        case easeInBack
        case easeOutBack
        case easeInOutBack
    }
    
    static func timingCurve(curve: TimingCurve, duration: Double = 0.35) -> Animation {
        switch curve {
        case .easeInSine:
            return Animation.timingCurve(0.47, 0, 0.745, 0.715, duration: duration)
        case .easeOutSine:
            return Animation.timingCurve(0.39, 0.575, 0.565, 1, duration: duration)
        case .easeInOutSine:
            return Animation.timingCurve(0.445, 0.05, 0.55, 0.95, duration: duration)
        case .easeInQuad:
            return Animation.timingCurve(0.55, 0.085, 0.68, 0.53, duration: duration)
        case .easeOutQuad:
            return Animation.timingCurve(0.25, 0.46, 0.45, 0.94, duration: duration)
        case .easeInOutQuad:
            return Animation.timingCurve(0.455, 0.03, 0.515, 0.955, duration: duration)
        case .easeInCubic:
            return Animation.timingCurve(0.55, 0.055, 0.675, 0.19, duration: duration)
        case .easeOutCubic:
            return Animation.timingCurve(0.215, 0.61, 0.355, 1, duration: duration)
        case .easeInOutCubic:
            return Animation.timingCurve(0.645, 0.045, 0.355, 1, duration: duration)
        case .easeInQuart:
            return Animation.timingCurve(0.895, 0.03, 0.685, 0.22, duration: duration)
        case .easeOutQuart:
            return Animation.timingCurve(0.165, 0.84, 0.44, 1, duration: duration)
        case .easeInOutQuart:
            return Animation.timingCurve(0.77, 0, 0.175, 1, duration: duration)
        case .easeInQuint:
            return Animation.timingCurve(0.755, 0.05, 0.855, 0.06, duration: duration)
        case .easeOutQuint:
            return Animation.timingCurve(0.23, 1, 0.32, 1, duration: duration)
        case .easeInOutQuint:
            return Animation.timingCurve(0.86, 0, 0.07, 1, duration: duration)
        case .easeInExpo:
            return Animation.timingCurve(0.95, 0.05, 0.795, 0.035, duration: duration)
        case .easeOutExpo:
            return Animation.timingCurve(0.19, 1, 0.22, 1, duration: duration)
        case .easeInOutExpo:
            return Animation.timingCurve(1, 0, 0, 1, duration: duration)
        case .easeInCirc:
            return Animation.timingCurve(0.6, 0.04, 0.98, 0.335, duration: duration)
        case .easeOutCirc:
            return Animation.timingCurve(0.075, 0.82, 0.165, 1, duration: duration)
        case .easeInOutCirc:
            return Animation.timingCurve(0.785, 0.135, 0.15, 0.86, duration: duration)
        case .easeInBack:
            return Animation.timingCurve(0.6, -0.28, 0.735, 0.045, duration: duration)
        case .easeOutBack:
            return Animation.timingCurve(0.175, 0.885, 0.32, 1.275, duration: duration)
        case .easeInOutBack:
            return Animation.timingCurve(0.68, -0.55, 0.265, 1.55, duration: duration)
        }
    }
}
