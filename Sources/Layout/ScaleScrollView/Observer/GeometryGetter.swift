//
//  GeometryGetter.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/7.
//

import SwiftUI
import Combine

@MainActor
final class ViewFrame: ObservableObject {
    
    var startingRect: CGRect?
    
    @Published var frame: CGRect {
        willSet {
            if newValue.minY == 0 && newValue != startingRect {
                self.startingRect = newValue
            }
        }
    }
    
    init() {
        self.frame = .zero
    }
}

