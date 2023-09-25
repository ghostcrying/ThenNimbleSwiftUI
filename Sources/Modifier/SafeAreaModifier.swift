//
//  SafeAreaModifier.swift
//  
//
//  Created by 陈卓 on 2023/8/7.
//

import SwiftUI

extension View {
    
    public func safeAreaModifier(_ safeArea: Binding<EdgeInsets>) -> some View {
        modifier(SafeAreaModifier(safeArea: safeArea))
    }
}

public struct SafeAreaModifier: ViewModifier {

    @Binding var safeArea: EdgeInsets

    public func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy -> AnyView in
                    DispatchQueue.main.async {
                        let area = proxy.safeAreaInsets
                        // This avoids an infinite layout loop
                        if area != self.safeArea {
                            self.safeArea = area
                        }
                    }
                    return AnyView(EmptyView())
                }
            )
    }
}
