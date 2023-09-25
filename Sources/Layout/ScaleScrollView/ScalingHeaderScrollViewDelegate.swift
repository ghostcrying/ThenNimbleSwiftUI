//
//  ScalingHeaderScrollViewDelegate.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/7.
//

#if canImport(UIKit)
import UIKit

final class ScalingHeaderScrollViewDelegate: NSObject, ObservableObject, UIScrollViewDelegate {
    
    var didPullToRefresh: () -> Void = { }
    var didScroll: () -> Void = {}
    var didEndDragging = {}

    // MARK: - UIScrollViewDelegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < -60 {
            didPullToRefresh()
        }
        didEndDragging()
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        didEndDragging()
    }
}
#endif
