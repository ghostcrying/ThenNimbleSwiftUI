//
//  Position.swift
//  Example
//
//  Created by 大大 on 2023/10/19.
//

import SwiftUI

// MARK: - PositionType

/// There are two type of positioning views - one that scrolls with the content,
/// and one that stays fixed
enum PositionType {
    case fixed
    case moving
}

// MARK: - Position

/// This struct is the currency of the Preferences, and has a type
/// (fixed or moving) and the actual Y-axis value.
/// It's Equatable because Swift requires it to be.
struct Position: Equatable {
    let type: PositionType
    let y: CGFloat
}

// MARK: - PositionPreferenceKey

/// This might seem weird, but it's necessary due to the funny nature of
/// how Preferences work. We can't just store the last position and merge
/// it with the next one - instead we have a queue of all the latest positions.
struct PositionPreferenceKey: PreferenceKey {
    typealias Value = [Position]

    static var defaultValue = [Position]()

    static func reduce(value: inout [Position], nextValue: () -> [Position]) {
        value.append(contentsOf: nextValue())
    }
}

// MARK: - PositionIndicator

struct PositionIndicator: View {
    let type: PositionType

    var body: some View {
        GeometryReader { proxy in
            // the View itself is an invisible Shape that fills as much as possible
            Color.clear
                // Compute the top Y position and emit it to the Preferences queue
                .preference(key: PositionPreferenceKey.self, value: [Position(type: self.type, y: proxy.frame(in: .global).minY)])
        }
    }
}
