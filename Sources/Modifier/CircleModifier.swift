//
//  CircleModifier.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/7.
//

import SwiftUI

public struct CircleButtonStyle: ButtonStyle {
    
    public var systemImageName: String
    
    public var foreground = Color.white
    public var background = Color.black
    
    public var width:  CGFloat = 40
    public var height: CGFloat = 40
    
    public func makeBody(configuration: Configuration) -> some View {
        Circle()
            .fill(background)
            .overlay(Image(systemName: systemImageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(foreground)
                .padding(12))
            .frame(width: width, height: height)
    }
}

public struct CircleModifier: ViewModifier {
    
    public var background = Color.white
    
    public var paddingSpace: CGFloat = 0
    
    @State private var size: CGSize = .zero
    @State private var diagonal: CGFloat = 0
    
    public func body(content: Content) -> some View {
        content
            .background(
                Circle()
                    .fill(background)
                    .frame(width: diagonal, height: diagonal)
            )
            .sizeModifier($size)
            .onChange(of: size) { newValue in
                diagonal = diagonalLength(width: newValue.width, height: newValue.height) + paddingSpace
            }
    }
}
