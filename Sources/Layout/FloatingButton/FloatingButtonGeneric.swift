//
//  FloatingButtonGeneric.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/7.
//

import SwiftUI

public class DefaultFloatingButton { fileprivate init() {} }
public class StraightFloatingButton: DefaultFloatingButton {}
public class CircleFloatingButton: DefaultFloatingButton {}

public struct FloatingButtonGeneric<T: DefaultFloatingButton, MainView: View, ButtonView: View>: View {
    private var floatingButton: FloatingButton<MainView, ButtonView>
    
    fileprivate init(floatingButton: FloatingButton<MainView, ButtonView>) {
        self.floatingButton = floatingButton
    }
    
    fileprivate init() {
        fatalError("don't call this method")
    }
    
    public var body: some View {
        floatingButton
    }
}

public extension FloatingButton {
    
    func straight() -> FloatingButtonGeneric<StraightFloatingButton, MainView, ButtonView> {
        var copy = self
        copy.menuType = .straight
        return FloatingButtonGeneric(floatingButton: copy)
    }
    
    func circle() -> FloatingButtonGeneric<CircleFloatingButton, MainView, ButtonView> {
        var copy = self
        copy.menuType = .circle
        return FloatingButtonGeneric(floatingButton: copy)
    }
}

public extension FloatingButtonGeneric where T : DefaultFloatingButton {
    
    func spacing(_ spacing: CGFloat) -> FloatingButtonGeneric {
        var copy = self
        copy.floatingButton.spacing = spacing
        return copy
    }
    
    func initialScaling(_ initialScaling: CGFloat) -> FloatingButtonGeneric {
        var copy = self
        copy.floatingButton.initialScaling = initialScaling
        return copy
    }
    
    func initialOffset(_ initialOffset: CGPoint) -> FloatingButtonGeneric {
        var copy = self
        copy.floatingButton.initialOffset = initialOffset
        return copy
    }
    
    func initialOffset(x: CGFloat = 0, y: CGFloat = 0) -> FloatingButtonGeneric {
        var copy = self
        copy.floatingButton.initialOffset = CGPoint(x: x, y: y)
        return copy
    }
    
    func initialOpacity(_ initialOpacity: Double) -> FloatingButtonGeneric {
        var copy = self
        copy.floatingButton.initialOpacity = initialOpacity
        return copy
    }
    
    func animation(_ animation: Animation) -> FloatingButtonGeneric {
        var copy = self
        copy.floatingButton.animation = animation
        return copy
    }
    
    func delays(delayDelta: Double) -> FloatingButtonGeneric {
        var copy = self
        copy.floatingButton.delays = (0..<self.floatingButton.buttons.count).map { i in
            return delayDelta * Double(i)
        }
        return copy
    }
    
    func delays(_ delays: [Double]) -> FloatingButtonGeneric {
        var copy = self
        copy.floatingButton.delays = delays
        return copy
    }

    func wholeMenuSize(_ wholeMenuSize: Binding<CGSize>) -> FloatingButtonGeneric {
        var copy = self
        copy.floatingButton.wholeMenuSize = wholeMenuSize
        return copy
    }

    func menuButtonsSize(_ menuButtonsSize: Binding<CGSize>) -> FloatingButtonGeneric {
        var copy = self
        copy.floatingButton.menuButtonsSize = menuButtonsSize
        return copy
    }
}

public extension FloatingButtonGeneric where T: StraightFloatingButton {
    
    func direction(_ direction: Direction) -> FloatingButtonGeneric {
        var copy = self
        copy.floatingButton.direction = direction
        return copy
    }
    
    func alignment(_ alignment: Alignment) -> FloatingButtonGeneric {
        var copy = self
        copy.floatingButton.alignment = alignment
        return copy
    }
}

public extension FloatingButtonGeneric where T: CircleFloatingButton {
    
    func startAngle(_ startAngle: Double) -> FloatingButtonGeneric {
        var copy = self
        copy.floatingButton.startAngle = startAngle
        return copy
    }
    
    func endAngle(_ endAngle: Double) -> FloatingButtonGeneric {
        var copy = self
        copy.floatingButton.endAngle = endAngle
        return copy
    }
    
    func radius(_ radius: Double) -> FloatingButtonGeneric {
        var copy = self
        copy.floatingButton.radius = radius
        return copy
    }
}
