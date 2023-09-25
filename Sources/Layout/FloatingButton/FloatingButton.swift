//
//  FloatingButton.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/7.
//

import SwiftUI

public enum Alignment {
    case left, right, top, bottom, center
}

public struct FloatingButton<MainView, ButtonView>: View where MainView: View, ButtonView: View {
    
    enum MenuType {
        case straight
        case circle
    }
    
    internal var mainView: MainView
    internal var buttons: [SubMenuButton<ButtonView>]
    
    internal var menuType = MenuType.straight
    internal var spacing: CGFloat = 10
    internal var initialScaling: CGFloat = 1
    internal var initialOffset: CGPoint = CGPoint()
    internal var initialOpacity: Double = 1
    internal var animation: Animation = .easeInOut(duration: 0.4)
    internal var delays: [Double] = []
    
    internal var wholeMenuSize: Binding<CGSize> = .constant(.zero)
    internal var menuButtonsSize: Binding<CGSize> = .constant(.zero)
    
    // straight
    internal var direction: Direction = .left
    internal var alignment: Alignment = .center
    
    // circle
    internal var startAngle: Double = .pi
    internal var endAngle: Double = 2 * .pi
    internal var radius: Double?
    
    @State internal var privateIsOpen: Bool = false
    public var isOpenBinding: Binding<Bool>?
    public var isOpen: Bool {
        get { isOpenBinding?.wrappedValue ?? privateIsOpen }
    }
    
    @State internal var coords: [CGPoint] = []
    @State internal var alignmentOffsets: [CGSize] = []
    @State internal var initialPositions: [CGPoint] = [] // if there is initial offset
    @State internal var sizes: [CGSize] = []
    @State internal var mainButtonSize = CGSize()
    
    private init(mainButtonView: MainView, buttons: [SubMenuButton<ButtonView>], isOpenBinding: Binding<Bool>?) {
        self.mainView = mainButtonView
        self.buttons = buttons
        self.isOpenBinding = isOpenBinding
    }
    
    public init(mainButtonView: MainView, buttons: [ButtonView]) {
        self.mainView = mainButtonView
        self.buttons = buttons.map { SubMenuButton(button: $0) }
    }
    
    public init(mainButtonView: MainView, buttons: [ButtonView], isOpen: Binding<Bool>) {
        self.mainView = mainButtonView
        self.buttons = buttons.map { SubMenuButton(button: $0) }
        self.isOpenBinding = isOpen
    }
    
    public var body: some View {
        ZStack {
                ForEach((0..<buttons.count), id: \.self) { i in
                    buttons[i]
                        .background(SubmenuButtonPreferenceViewSetter())
                        .offset(alignmentOffsets.isEmpty ? .zero : alignmentOffsets[i])
                        .offset(buttonOffset(at: i))
                        .scaleEffect(isOpen ? 1 : initialScaling)
                        .opacity(isOpen ? 1 : initialOpacity)
                        .animation(buttonAnimation(at: i), value: isOpen)
                }
            
            MainButtonViewInternal(isOpen: isOpenBinding ?? $privateIsOpen, mainView: mainView)
                .buttonStyle(PlainButtonStyle())
                .sizeModifier($mainButtonSize)
        }
        .onPreferenceChange(SizesPreferenceKey.self) { (sizes) in
            let sizes = sizes.map { CGSize(width: CGFloat(Int($0.width + 0.5)), height: CGFloat(Int($0.height + 0.5))) }
            if sizes != self.sizes {
                self.sizes = sizes
                calculateCoords()
            }
        }
        .onChange(of: mainButtonSize) { _ in
            calculateCoords()
        }
    }
    
}

// MARK: - Private Methods
extension FloatingButton {
    
    private func buttonAnimation(at i: Int) -> Animation {
        animation.delay(delays.isEmpty
                        ? Double(0)
                        : (isOpen ? delays[delays.count - i - 1] : delays[i])
        )
    }
    
    private func buttonOffset(at i: Int) -> CGSize {
        isOpen
        ? CGSize(width: coords[safe: i].x, height: coords[safe: i].y)
        : CGSize(width: initialPositions.isEmpty ? 0 : initialPositions[safe: i].x,
                 height: initialPositions.isEmpty ? 0 : initialPositions[safe: i].y)
    }
    
    private func roundToTwoDigits(_ size: CGSize) -> CGSize {
        CGSize(width: ceil(size.width * 100) / 100, height: ceil(size.height * 100) / 100)
    }
    
    private func calculateCoords() {
        switch menuType {
        case .straight:
            calculateCoordsStraight()
        case .circle:
            calculateCoordsCircle()
        }
    }
    
    private func calculateCoordsStraight() {
        guard sizes.count > 0, mainButtonSize != .zero else {
            return
        }

        let sizes = sizes.map { roundToTwoDigits($0) }
        let allSizes = [roundToTwoDigits(mainButtonSize)] + sizes
        
        var coord = CGPoint.zero
        coords = (0..<sizes.count).map { i -> CGPoint in
            let width = allSizes[i].width / 2 + allSizes[i+1].width / 2
            let height = allSizes[i].height / 2 + allSizes[i+1].height / 2

            switch direction {
            case .left:
                coord = CGPoint(x: coord.x - width - spacing, y: coord.y)
            case .right:
                coord = CGPoint(x: coord.x + width + spacing, y: coord.y)
            case .top:
                coord = CGPoint(x: coord.x, y: coord.y - height - spacing)
            case .bottom:
                coord = CGPoint(x: coord.x, y: coord.y + height + spacing)
            }
            return coord
        }
        
        if initialOffset.x != 0 || initialOffset.y != 0 {
            initialPositions = (0..<sizes.count).map { i -> CGPoint in
                CGPoint(x: coords[i].x + initialOffset.x,
                        y: coords[i].y + initialOffset.y)
            }
        } else {
            initialPositions = Array(repeating: .zero, count: sizes.count)
        }
        
        alignmentOffsets = (0..<sizes.count).map { i -> CGSize in
            switch alignment {
            case .left:
                return CGSize(width: sizes[i].width / 2 - mainButtonSize.width / 2, height: 0)
            case .right:
                return CGSize(width: -sizes[i].width / 2 + mainButtonSize.width / 2, height: 0)
            case .top:
                return CGSize(width: 0, height: sizes[i].height / 2 - mainButtonSize.height / 2)
            case .bottom:
                return CGSize(width: 0, height: -sizes[i].height / 2 + mainButtonSize.height / 2)
            case .center:
                return CGSize()
            }
        }

        wholeMenuSize.wrappedValue = .zero
        menuButtonsSize.wrappedValue = .zero
        for size in sizes {
            menuButtonsSize.wrappedValue = CGSize(
                width: max(size.width, menuButtonsSize.wrappedValue.width),
                height: menuButtonsSize.wrappedValue.height + size.height + spacing
            )
        }
        wholeMenuSize.wrappedValue = CGSize(
            width: max(menuButtonsSize.wrappedValue.width, mainButtonSize.width),
            height: menuButtonsSize.wrappedValue.height + mainButtonSize.height
        )
    }
    
    private func calculateCoordsCircle() {
        guard sizes.count > 0, mainButtonSize != .zero else {
            return
        }

        let count = buttons.count
        var radius: Double = 60
        if let r = self.radius {
            radius = r
        } else if let buttonWidth = sizes.first?.width {
            radius = Double((mainButtonSize.width + buttonWidth) / 2 + spacing)
        }

        coords = (0..<count).map { i in
            let angle = (endAngle - startAngle) / Double(count - 1) * Double(i) + startAngle
            return CGPoint(x: radius*cos(angle), y: radius*sin(angle))
        }

        var finalFrame = CGRect(x: -mainButtonSize.width/2, y: -mainButtonSize.height/2, width: mainButtonSize.width, height: mainButtonSize.height)
        let buttonSize = sizes.first?.width ?? 0
        let buttonRadius = buttonSize / 2

        for coord in coords {
            finalFrame = finalFrame.union(CGRect(x: coord.x - buttonRadius, y: coord.y - buttonRadius, width: buttonSize, height: buttonSize))
        }

        wholeMenuSize.wrappedValue = finalFrame.size
        menuButtonsSize.wrappedValue = finalFrame.size
    }

}

extension FloatingButton {
    
    struct SubMenuButton<ButtonView: View>: View {
        var button: ButtonView
        var action: () -> () = { }
        
        var body: some View {
            Button {
                action()
            } label: {
                button
            }
            .buttonStyle(.plain)
        }
    }

    struct MainButtonViewInternal<MainView: View>: View {
        
        @Binding public var isOpen: Bool
        
        var mainView: MainView
        
        var body: some View {
            Button {
                isOpen.toggle()
            } label: {
                mainView
            }
        }
    }
    
    struct SubmenuButtonPreferenceViewSetter: View {

        var body: some View {
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color.clear)
                    .preference(key: SizesPreferenceKey.self,
                                value: [geometry.frame(in: .global).size])
            }
        }
    }

}

