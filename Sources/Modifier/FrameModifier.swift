//
//  File.swift
//  
//
//  Created by 陈卓 on 2023/8/7.
//

import SwiftUI
// MARK: - FrameGetter

public struct FrameGetter: ViewModifier {

    @Binding var frame: CGRect

    public func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy -> AnyView in
                    DispatchQueue.main.async {
                        let rect = proxy.frame(in: .global)
                        // This avoids an infinite layout loop
                        if rect.integral != self.frame.integral {
                            self.frame = rect
                        }
                    }
                    return AnyView(EmptyView())
                }
            )
    }
}

public extension View {
    
    func frameGetter(_ frame: Binding<CGRect>) -> some View {
        modifier(FrameGetter(frame: frame))
    }
    
}
