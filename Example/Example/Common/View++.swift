//
//  View++.swift
//  Example
//
//  Created by 陈卓 on 2023/8/7.
//

import SwiftUI

extension View {
        
    func shadowedStyle() -> some View {
        self
            .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 0)
            .shadow(color: .black.opacity(0.16), radius: 24, x: 0, y: 0)
    }
    
    func customButtonStyle(
        foreground: Color = .black,
        background: Color = .white
    ) -> some View {
        self.buttonStyle(
            ExampleButtonStyle(
                foreground: foreground,
                background: background
            )
        )
    }

}

extension View {

    func fontBold(color: Color = .black, size: CGFloat) -> some View {
        foregroundColor(color).font(.custom("Circe-Bold", size: size))
    }

    func fontRegular(color: Color = .black, size: CGFloat) -> some View {
        foregroundColor(color).font(.custom("Circe", size: size))
    }
}
