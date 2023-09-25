//
//  SwiftUIView.swift
//  
//
//  Created by 陈卓 on 2023/8/7.
//

import Combine
import SwiftUI

public struct AnimationCompletionObserverModifier<Value>: AnimatableModifier where Value: VectorArithmetic, Value: Comparable {

    /// While animating, SwiftUI changes the old input value to the new target value using this property. This value is set to the old value until the animation completes.
    public var animatableData: Value {
        didSet {
            notifyCompletionIfFinished()
        }
    }

    /// The target value for which we're observing. This value is directly set once the animation starts. During animation, `animatableData` will hold the oldValue and is only updated to the target value once the animation completes.
    private var targetValue: Value

    /// The completion callback which is called once the animation completes.
    private var completion: () -> Void

    init(observedValue: Value, completion: @escaping () -> Void) {
        self.completion = completion
        self.animatableData = observedValue
        targetValue = observedValue
    }

    /// Verifies whether the current animation is finished and calls the completion callback if true.
    private func notifyCompletionIfFinished() {
        guard animatableData == targetValue else { return }

        /// Dispatching is needed to take the next runloop for the completion callback.
        /// This prevents errors like "Modifying state during view update, this will cause undefined behavior."
        DispatchQueue.main.async {
            self.completion()
        }
    }

    public func body(content: Content) -> some View {
        /// We're not really modifying the view so we can directly return the original input value.
        return content
    }
}

struct AnimatableModifierDouble: AnimatableModifier {

    var targetValue: Double
    static var done = false

    // SwiftUI gradually varies it from old value to the new value
    var animatableData: Double {
        didSet {
            checkIfFinished()
        }
    }
    var completion: () -> ()

    // Re-created every time the control argument changes
    init(bindedValue: Double, completion: @escaping () -> ()) {
        self.completion = completion

        // Set animatableData to the new value. But SwiftUI again directly
        // and gradually varies the value while the body
        // is being called to animate. Following line serves the purpose of
        // associating the extenal argument with the animatableData.
        self.animatableData = bindedValue
        targetValue = bindedValue
        AnimatableModifierDouble.done = false
    }

    func checkIfFinished() -> () {
        if AnimatableModifierDouble.done { return }
        let delta = 0.1
        if animatableData > targetValue - delta &&
            animatableData < targetValue + delta {
            AnimatableModifierDouble.done = true
            DispatchQueue.main.async {
                self.completion()
            }
        }
    }

    func body(content: Content) -> some View {
        content
    }
}

public extension View {

    func onAnimationCompleted(for value: Double, completion: @escaping () -> Void) -> some View {
        modifier(AnimatableModifierDouble(bindedValue: value, completion: completion))
    }
}
