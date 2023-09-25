//
//  SizeModifier.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/7.
//

import SwiftUI

public extension View {

    /// Examples
    /// ```swift
    /// @State private var mainButtonSize = CGSize()
    /// Text("🐶")
    ///    .font(.title)
    ///    .padding(20)
    ///    .background(Color.red)
    ///    .clipShape(Circle())
    ///    .sizeModifier($mainButtonSize)
    ///    .onChange(of: mainButtonSize) { newValue in
    ///         print(newValue)
    ///     }
    /// ```
    func sizeModifier(_ size: Binding<CGSize>) -> some View {
        modifier(SizeModifier(size: size))
    }
}

/// Get View Size Modifier
public struct SizeModifier: ViewModifier {
    
    @Binding public var size: CGSize

    public func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy -> Color in
                    if proxy.size != self.size {
                        DispatchQueue.main.async {
                            self.size = proxy.size
                        }
                    }
                    return Color.clear
                }
            )
    }
}
