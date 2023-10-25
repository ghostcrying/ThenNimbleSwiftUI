//
//  RefreshDefaultView.swift
//  Example
//
//  Created by 大大 on 2023/10/25.
//

import SwiftUI
import ThenNimbleSwiftUI

struct RefreshDefaultView: View {
    @State private var now = Date()

    var body: some View {
        VStack {
            Text("🌲")
                .frame(height: 100)
            Divider()
                .frame(height: 1)
            RefreshableScrollView(
                onRefresh: { done in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                        self.now = Date()
                        done()
                    }
                }) {
                    VStack {
                        ForEach(1 ..< 5) { _ in
                            NavigationLink {
                                Text("++")
                            } label: {
                                Text("++").padding(.bottom, 10)
                            }
                        }
                    }
                }
        }
        .navigationTitle("Default")
    }
}

#Preview {
    RefreshDefaultView()
}
