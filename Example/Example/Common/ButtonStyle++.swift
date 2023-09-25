//
//  ButtonStyle.swift
//  Example
//
//  Created by 陈卓 on 2023/8/7.
//

import SwiftUI

struct CircleButtonStyle: ButtonStyle {

    var imageName: String
    var foreground = Color.black
    var background = Color.white
    var width: CGFloat = 40
    var height: CGFloat = 40

    func makeBody(configuration: Configuration) -> some View {
        Circle()
            .fill(background)
            .overlay(Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(foreground)
                        .padding(12))
            .frame(width: width, height: height)
    }
}

struct ExampleButtonStyle: ButtonStyle {
    let foreground: Color
    let background: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.45 : 1)
            .foregroundColor(configuration.isPressed ? foreground.opacity(0.55) : foreground)
            .background(configuration.isPressed ? background.opacity(0.55) : background)
    }
}
