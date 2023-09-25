//
//  ClassReference.swift
//  
//
//  Created by 陈卓 on 2023/8/7.
//

import Foundation

final class ClassReference<T> {
    var value: T

    init(_ value: T) {
        self.value = value
    }
}

