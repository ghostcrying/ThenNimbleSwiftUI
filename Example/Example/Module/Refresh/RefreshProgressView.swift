//
//  RefreshProgressView.swift
//  Example
//
//  Created by 大大 on 2023/10/25.
//

import SwiftUI
import ThenNimbleSwiftUI

struct RefreshProgressView: View {
    var body: some View {
        List {
            ForEach(0 ..< 5) { _ in
                Text("++").padding(.bottom, 10)
            }
        }
        .refreshableCompat(
            showsIndicators: false,
            onRefresh: { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    done()
                }
            },
            progress: { state, offset in
                if state == .waiting {
                    ActivityIndicatorView(isVisible: .constant(true), type: .growingArc(lineWidth: 2))
                        .foregroundColor(.red)
                        .frame(width: 30, height: 30)
                }
                EmptyView()
            }
        )
        .navigationTitle("Refresh Progress")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    RefreshProgressView()
}
