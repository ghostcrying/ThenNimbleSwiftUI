//
//  RefreshCompactView.swift
//  Example
//
//  Created by 大大 on 2023/10/25.
//

import SwiftUI
import ThenNimbleSwiftUI

struct RefreshCompactView: View {
    @State private var now = Date()

    var body: some View {
        VStack {
            ForEach(1 ..< 5) {
                Text("\(Calendar.current.date(byAdding: .hour, value: $0, to: self.now)!)")
                    .padding(.bottom, 10)
            }
        }
        .refreshableCompat(
            showsIndicators: false,
            onRefresh: { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.now = Date()
                    done()
                }
            },
            progress: { state, offset in
                ActivityIndicatorView(isVisible: .constant(true), type: .default())
                    .frame(width: 30, height: 30)
                    .foregroundColor(.red)
            }
        )
        .navigationTitle("Refresh Compact")
    }
}

#Preview {
    RefreshCompactView()
}
