//
//  Collection++.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/7.
//

import Foundation

extension Collection where Element == CGPoint {
    
    subscript (safe index: Index) -> CGPoint {
        return indices.contains(index) ? self[index] : .zero
    }
}
