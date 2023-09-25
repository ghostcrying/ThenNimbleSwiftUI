//
//  Animation++.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/9.
//

import Combine
import SwiftUI

struct Keyframe {
    let scale: CGFloat
    let duration: Double
}
/*
 Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
     withAnimation(Animation.timingCurve(0.15, 0.46, 0.9, 0.6, duration: 0.25)) {
         oddOffsety = deltayY
         evenOffsety = -deltayY
     }
     withAnimation(Animation.timingCurve(0.15, 0.46, 0.9, 0.6, duration: 0.5).delay(0.25)) {
         oddOffsety = -deltayY
         evenOffsety = deltayY
     }
     withAnimation(Animation.timingCurve(0.15, 0.46, 0.9, 0.6, duration: 0.25).delay(0.75)) {
         oddOffsety = 0
         evenOffsety = 0
     }
 }.fire()
 */

//extension Animation {
//
//    func keyframeAnimation(keyframes: [Keyframe]) -> Animation {
//        var animation = self
//        for keyframe in keyframes {
//            animation = animation.concatenating(
//                Animation.easeInOut(duration: keyframe.duration)
//                    .scaleEffect(keyframe.scale)
//            )
//        }
//
//        return animation
//    }
//}
