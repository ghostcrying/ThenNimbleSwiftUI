//
//  RefreshIndicator.swift
//  Example
//
//  Created by 大大 on 2023/10/19.
//

import SwiftUI
import UIKit

// MARK: - RefreshActivityIndicator

/// Wraps a UIActivityIndicatorView as a loading spinner that works on all SwiftUI versions.
public struct RefreshActivityIndicator: UIViewRepresentable {
    public typealias UIView = UIActivityIndicatorView
    public var isAnimating: Bool = true
    public var alpha: CGFloat = 0 {
        didSet {
            print("设置透明度")
        }
    }
    public var configuration = { (indicator: UIView) in }

    public init(isAnimating: Bool, alpha: CGFloat, configuration: ((UIView) -> Void)? = nil) {
        self.isAnimating = isAnimating
        self.alpha = alpha
        if let configuration = configuration {
            self.configuration = configuration
        }
    }

    public func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView {
        let v = UIView(style: .medium)
        v.hidesWhenStopped = false
        v.color = UIColor.secondaryLabel
        v.transform = .init(scaleX: 1.2, y: 1.2)
        return v
    }

    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        self.isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        uiView.alpha = self.alpha
        print("刷新透明度")
        self.configuration(uiView)
    }
}

