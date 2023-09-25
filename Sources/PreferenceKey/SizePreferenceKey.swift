//
//  SizePreferenceKey.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/7.
//

import SwiftUI

/// This is only an example for PreferenceKey
/// Record the newest size value
public struct NewSizePreferenceKey: PreferenceKey {
    
    public static let defaultValue: CGSize = .zero
    
    /// you kan set custom rule
    public static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

/// Record the all size value
public struct SizesPreferenceKey: PreferenceKey {
    
    public static let defaultValue: [CGSize] = []
    
    public static func reduce(value: inout [CGSize], nextValue: () -> [CGSize]) {
        value += nextValue()
    }
}

/// Record the max cgfloat value
public struct MaxCGFloatPreferenceKey: PreferenceKey {
    
    public static var defaultValue: CGFloat = 0
    
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

/// Record the min cgfloat value
public struct MinCGFloatPreferenceKey: PreferenceKey {
    
    public static var defaultValue: CGFloat = 0
    
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = min(value, nextValue())
    }
}

/// Record the max double value
public struct MaxDoublePreferenceKey: PreferenceKey {
    
    public static var defaultValue: CGFloat = 0
    
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

/// Record the min double value
public struct MinDoublePreferenceKey: PreferenceKey {
    
    public static var defaultValue: CGFloat = 0
    
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = min(value, nextValue())
    }
}
