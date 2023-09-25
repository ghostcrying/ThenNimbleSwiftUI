//
//  SwiftUIView.swift
//  
//
//  Created by 陈卓 on 2023/8/7.
//

import SwiftUI
import Combine

#if os(iOS)

extension View {

    func transparentNonAnimatingFullScreenCover<Content: View>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View {
        modifier(TransparentNonAnimatableFullScreenModifier(isPresented: isPresented, fullScreenContent: content))
    }
}

private struct TransparentNonAnimatableFullScreenModifier<FullScreenContent: View>: ViewModifier {

    @Binding var isPresented: Bool
    let fullScreenContent: () -> (FullScreenContent)

    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented) { isPresented in
                UIView.setAnimationsEnabled(false)
            }
            .fullScreenCover(isPresented: $isPresented, content: {
                ZStack {
                    fullScreenContent()
                }
                .background(FullScreenCoverBackgroundRemovalView())
                .onAppear {
                    if !UIView.areAnimationsEnabled {
                        UIView.setAnimationsEnabled(true)
                    }
                }
                .onDisappear {
                    if !UIView.areAnimationsEnabled {
                        UIView.setAnimationsEnabled(true)
                    }
                }
            })
    }
}

private struct FullScreenCoverBackgroundRemovalView: UIViewRepresentable {

    private class BackgroundRemovalView: UIView {

        override func didMoveToWindow() {
            super.didMoveToWindow()

            superview?.superview?.backgroundColor = .clear
        }

    }

    func makeUIView(context: Context) -> UIView {
        return BackgroundRemovalView()
    }

    func updateUIView(_ uiView: UIView, context: Context) {}

}

#endif
